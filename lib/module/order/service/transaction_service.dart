import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webordernft/module/order/service/model/order_list.dart';
import '../../../config/networking.dart';
import 'dart:html' as html;

class TransactionService {
  static getOrderList(context, pg, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'ord/listOrders?page=$pg';
    String jsonInput = json.encode(params);

    print(jsonInput);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    OrderList result = OrderList.fromJson(decodedData);

    return result;
  }

  // static postCsv(context, params, token) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? _token = prefs.getString('token');

  //   String url = 'ord/csv/export-csv';
  //   String jsonInput = json.encode(params);

  //   print(jsonInput);

  //   NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

  //   Response response = await networkHelper.postRequestHttp(context);

  //   var decodedData = json.decode(response.body);

  //   OrderList result = OrderList.fromJson(decodedData);
  //   if (response.statusCode == 200) {
  //     final csvData = response.body;
  //     final blob = html.Blob([csvData], 'text/csv');
  //     final downloadUrl = html.Url.createObjectUrlFromBlob(blob);
  //     final anchor = html.AnchorElement(href: downloadUrl)
  //       ..setAttribute('download', 'orders.csv')
  //       ..click();
  //     html.Url.revokeObjectUrl(downloadUrl);

  //     print('CSV file successfully downloaded');
  //   } else {
  //     print('Failed to download CSV file. Status code: ${response.statusCode}');
  //   }
  //   return result;
  // }

  static Future<void> downloadCsv(BuildContext context, param) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      print('Token is not available');
      return;
    }

    String url = 'ord/export-csv';
    String jsonInput = jsonEncode(param.toJson());

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, token);
    Response response = await networkHelper.postRequestHttp(context);

    if (response.statusCode == 200) {
      final csvData = response.body;
      final blob = html.Blob([csvData], 'text/csv');
      final downloadUrl = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: downloadUrl)
        ..setAttribute('download', 'orders.csv')
        ..click();
      html.Url.revokeObjectUrl(downloadUrl);

      print('CSV file successfully downloaded');
    } else {
      print('Failed to download CSV file. Status code: ${response.statusCode}');
    }
  }
}
