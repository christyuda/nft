import 'dart:convert';

import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webordernft/module/login/service/model/list_menu.dart';
import 'package:webordernft/module/login/service/model/profile.dart';

import '../../../config/networking.dart';
import '../provider/login_provider.dart';
import 'model/pin_menu_byrole.dart';
import 'model/response_login.dart';
import 'model/response_logout.dart';

class LoginService {
  static Future<List> getListMenu(context) async {
    final _logprov = Provider.of<LoginProvider>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? _roleid = prefs.getInt('roleid');
    final String? _token = prefs.getString('token');

    PinMenuByRole params = PinMenuByRole(
      roleid: _roleid.toString(),
    );
    var jsonInput = jsonEncode(params);

    // print(jsonInput);
    // print(_token);

    NetworkHelper networkHelper =
        NetworkHelper('menus/menubyrole', jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];
    List<ListMenu> result =
        collection.map((json) => ListMenu.fromJson(json)).toList();

    return result;
  }

  static Future submitLoginCredentials(context, pinOauth) async {
    final _logprov = Provider.of<LoginProvider>(context, listen: false);
    var jsonInput = jsonEncode(pinOauth);
    final String url = 'auth/login';

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, '');

    Response response = await networkHelper.postForLogin(context);

    var decodedData = json.decode(response.body);

    ResponseLogin result = ResponseLogin.fromJson(decodedData);

    return result;
  }

  static Future submitLogin(context, pinOauth) async {
    final _logprov = Provider.of<LoginProvider>(context, listen: false);
    var jsonInput = jsonEncode(pinOauth);

    NetworkHelper networkHelper = NetworkHelper('auth/login', jsonInput, '');

    Response response = await networkHelper.postForLogin(context);

    var decodedData = json.decode(response.body);

    ResponseLogin result = ResponseLogin.fromJson(decodedData);

    return result;
  }

  static Future submitLogout(context, pin) async {
    final _logprov = Provider.of<LoginProvider>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    var jsonInput = jsonEncode(pin);

    NetworkHelper networkHelper =
        NetworkHelper('auth/logout', jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    ResponseLogout result = ResponseLogout.fromJson(decodedData);

    return result;
  }

  static Future getProfileUser(context, pinOauth) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    var jsonInput = jsonEncode(pinOauth);

    NetworkHelper networkHelper =
        NetworkHelper('user/profileuser', jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    ProfileLogin result = ProfileLogin.fromJson(decodedData);

    return result;
  }
}
