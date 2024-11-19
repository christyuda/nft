import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webordernft/config/networking.dart';
import 'package:webordernft/module/login/provider/login_provider.dart';
import 'package:webordernft/module/order/service/model/order_payment.dart';
import 'package:webordernft/module/order/service/model/order_response.dart';
import 'dart:html' as html;

class OrderService {
  static Future<OrderResponse> submitOrder(
      BuildContext context, Map<String, dynamic> orderData) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    await loginProvider.loginWithPresetCredentials(context);

    final String token = loginProvider.token ?? '';

    final String bearerToken = '$token';

    var jsonInput = jsonEncode(orderData);
    final String url = 'ord/addOrder';

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, bearerToken);

    try {
      http.Response response = await networkHelper.postRequestHttp(context);
      var decodedData = json.decode(response.body);

      OrderResponse result = OrderResponse.fromJson(decodedData);
      return result;
    } catch (e) {
      throw Exception('Failed to submit the order: $e');
    }
  }

  static Future<http.Response> submitPaymentProof(
      BuildContext context, OrderPaymentProof orderPaymentProof) async {
    // Get login provider and token
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    String? token = loginProvider.token;

    if (token == null || token.isEmpty) {
      throw Exception('Token is missing. User needs to log in first.');
    }

    final String bearerToken = 'Bearer $token';

    // Get API base URL from environment
    final env = Provider.of<LoginProvider>(context, listen: false);
    final String baseUrl = env.apiEndPoint ?? '';
    final String fullUrl = '$baseUrl' + 'ord/uploadBuktiBayar';

    // NetworkHelper is used for headers
    NetworkHelper networkHelper = NetworkHelper(fullUrl, '', bearerToken);

    try {
      // Create multipart request for sending file and other data
      var request = http.MultipartRequest('POST', Uri.parse(fullUrl));

      // Add cellphone as form field
      request.fields['cellphone'] = orderPaymentProof.cellphone;
      request.fields['paymentChanel'] =
          orderPaymentProof.paymentChannel.toString();
      request.fields['paymentStatus'] =
          orderPaymentProof.paymentStatus.toString();

      // Add the image file as part of the form-data
      if (orderPaymentProof.fileBytes != null) {
        // For Flutter web, use fileBytes
        request.files.add(http.MultipartFile.fromBytes(
            'image', orderPaymentProof.fileBytes!,
            filename: orderPaymentProof.fileName));
      } else if (orderPaymentProof.imagePath != null) {
        // For mobile or desktop, use file path
        request.files.add(await http.MultipartFile.fromPath(
            'image', orderPaymentProof.imagePath!));
      } else {
        throw Exception('No file selected.');
      }

      // Add the headers, including Authorization
      request.headers.addAll(await networkHelper.headerMultipartData());

      // Send the multipart request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print('File name: ${orderPaymentProof.fileName}');
      print('File bytes: ${orderPaymentProof.fileBytes}');
      print('Cellphone: ${orderPaymentProof.cellphone}');
      print('Headers: ${request.headers}');

      // Check response status
      if (response.statusCode == 200) {
        print('Payment proof uploaded successfully');
      } else {
        print('Failed to upload payment proof: ${response.body}');
      }

      return response;
    } catch (e) {
      throw Exception('Failed to upload payment proof: $e');
    }
  }
}
