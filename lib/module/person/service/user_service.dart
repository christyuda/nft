import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widget/general_response.dart';
import '../../../config/networking.dart';
import '../../role/service/model/list_role.dart';
import 'model/list_user.dart';
import 'model/profile.dart';

class UserService {
  static submitCreateAkunUser(context, param) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String jsonInput = jsonEncode(param);
    String url = 'user/register';
    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    GeneralResponse _result = GeneralResponse.fromJson(decodedData);

    return _result;
  }

  static getRole(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    NetworkHelper networkHelper = NetworkHelper('roles/getrole', '', _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);
    //
    List collection = decodedData['data'];
    List<Role> result = collection.map((json) => Role.fromJson(json)).toList();

    return result;
  }

  static getUser(context, pg, params) async {
    // static Future<List<Users>> getUser(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'user/listuser?page=${pg}';

    String jsonInput = json.encode(params);

    print(jsonInput);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    // Response response = await networkHelper.getRequest(context, url);
    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    Users result = Users.fromJson(decodedData);
    // List collection = decodedData['data'];
    //
    // List<Users> result = collection.map((e) => Users.fromJson(e)).toList();

    return result;
  }

  // static getTesProfile(context) async {
  static getTesProfile(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'user/profileuser';

    NetworkHelper networkHelper = NetworkHelper(url, '', _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];

    List<Profile> result =
        collection.map((json) => Profile.fromJson(json)).toList();

    return result;
  }
}
