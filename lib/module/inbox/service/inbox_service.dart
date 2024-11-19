import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widget/general_response.dart';
import '../../../config/networking.dart';
import 'model/ticket_pagination.dart';

class InboxService {
  static getInbox(context, pg, params) async {
    // static Future<List<Users>> getUser(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'inbox?page=${pg}';

    String jsonInput = json.encode(params);

    // print(jsonInput);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    // Response response = await networkHelper.getRequest(context, url);
    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    TicketPagination result = TicketPagination.fromJson(decodedData);

    return result;
  }

  static ambilTiket(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'inbox/ambilTiket';

    String jsonInput = json.encode(params);

    print(jsonInput);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    // Response response = await networkHelper.getRequest(context, url);
    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    GeneralResponse result = GeneralResponse.fromJson(decodedData);

    return result;
  }

  static submitTiket(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'inbox/submitTiket';

    String jsonInput = json.encode(params);

    print(jsonInput);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    // Response response = await networkHelper.getRequest(context, url);
    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    GeneralResponse result = GeneralResponse.fromJson(decodedData);

    return result;
  }
}
