import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webordernft/common/widget/general_response.dart';

import '../../../config/networking.dart';
import '../../ticket/service/model/list_kategori.dart';
import 'model/nodes.dart';

class WorkflowService {
  //submit

  static submitKategori(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? _roleid = prefs.getInt('roleid');
    final String? _token = prefs.getString('token');

    var jsonInput = jsonEncode(params);
    NetworkHelper networkHelper =
        NetworkHelper('workflow/addsubkategori', jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    GeneralResponse result = GeneralResponse.fromJson(decodedData);

    return result;
  }

  static submitWorkflowType(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? _token = prefs.getString('token');

    var jsonInput = jsonEncode(params);
    NetworkHelper networkHelper =
        NetworkHelper('workflow/addWorkflowType', jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    GeneralResponse result = GeneralResponse.fromJson(decodedData);

    return result;
  }

  static addNodes(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? _token = prefs.getString('token');

    var jsonInput = jsonEncode(params);
    NetworkHelper networkHelper =
        NetworkHelper('workflow/addWorkflowNode', jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    GeneralResponse result = GeneralResponse.fromJson(decodedData);

    return result;
  }

  static submitMapping(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? _token = prefs.getString('token');

    var jsonInput = jsonEncode(params);
    NetworkHelper networkHelper =
        NetworkHelper('workflow/mappingWorkflow', jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    GeneralResponse result = GeneralResponse.fromJson(decodedData);

    return result;
  }

  // get

  static getKategori(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? _token = prefs.getString('token');

    NetworkHelper networkHelper =
        NetworkHelper('workflow/getKategori', '', _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];
    List<ListKategori> result =
        collection.map((json) => ListKategori.fromJson(json)).toList();

    return result;
  }

  static getsubKategori(context, pin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? _token = prefs.getString('token');

    var jsonInput = jsonEncode(pin);

    NetworkHelper networkHelper =
        NetworkHelper('workflow/getSubKategori', jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];
    List<ListKategori> result =
        collection.map((json) => ListKategori.fromJson(json)).toList();

    return result;
  }

  static getWorkflowtype(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? _token = prefs.getString('token');

    NetworkHelper networkHelper =
        NetworkHelper('workflow/getWorkflowType', '', _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];
    List<Nodes> result =
        collection.map((json) => Nodes.fromJson(json)).toList();

    return result;
  }
}
