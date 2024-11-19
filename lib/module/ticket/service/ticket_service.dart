import 'dart:convert';

import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/networking.dart';
import '../../login/provider/login_provider.dart';
import 'model/list_kategori.dart';
import 'model/list_sumber_aduan.dart';
import 'model/response_cek_pasport.dart';
import 'model/response_create_ticket.dart';
import 'model/response_getnode.dart';

class TicketService {
  static validasiPassport(context, pinInput) async {
    final _logprov = Provider.of<LoginProvider>(context, listen: false);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    var jsonInput = jsonEncode(pinInput);

    var url =
        'https://pospmi-api.posindonesia.co.id/api/v1/recovery/passport/check';

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response responseget =
        await networkHelper.postRequestPMI(context, url, jsonInput, _token);

    var decodedData = json.decode(responseget.body);

    ResponseCheckPasport result = ResponseCheckPasport.fromJson(decodedData);

    return result;
  }

  Future<Map<String, String>> headerGeneralPMI(token) async {
    Map<String, String> headersGet = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": 'Bearer ' + token,
    };
    return headersGet;
  }

  static Future<List<ListKategori>> getListKategori(context) async {
    final _logprov = Provider.of<LoginProvider>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? _roleid = prefs.getInt('roleid');
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

  static Future<List<ListKategori>> getListSubKategori(
      context, parentId) async {
    final _logprov = Provider.of<LoginProvider>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? _roleid = prefs.getInt('roleid');
    final String? _token = prefs.getString('token');

    var jsonInput = jsonEncode({'parentid': '${parentId}'});

    NetworkHelper networkHelper =
        NetworkHelper('workflow/getSubKategori', jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];
    List<ListKategori> result =
        collection.map((json) => ListKategori.fromJson(json)).toList();

    return result;
  }

  static Future getWorkflowNode(context, params) async {
    final _logprov = Provider.of<LoginProvider>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? _roleid = prefs.getInt('roleid');
    final String? _token = prefs.getString('token');

    var jsoninput = jsonEncode(params);

    NetworkHelper networkHelper =
        NetworkHelper('workflow/getWorkflowNode', jsoninput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    ResponseGetNodes _result = ResponseGetNodes.fromJson(decodedData);

    // List collection = decodedData['data']['nodes'];
    // List<ListNodes> result =
    //     collection.map((json) => ListNodes.fromJson(json)).toList();

    return _result;
  }

  static getSumberAduan(context) async {
    final _logprov = Provider.of<LoginProvider>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? _roleid = prefs.getInt('roleid');
    final String? _token = prefs.getString('token');

    NetworkHelper networkHelper =
        NetworkHelper('workflow/sumberAduan', '', _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];
    List<ListSumberAduan> result =
        collection.map((json) => ListSumberAduan.fromJson(json)).toList();

    return result;
  }

  static submitCreateTicket(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? _token = prefs.getString('token');

    var jsonInput = jsonEncode(params);

    NetworkHelper networkHelper =
        NetworkHelper('workflow/createTicket', jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    ResponseCreateTicket result = ResponseCreateTicket.fromJson(decodedData);

    return result;
  }
}
