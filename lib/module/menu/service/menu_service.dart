import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webordernft/common/widget/general_response.dart';
import 'package:webordernft/module/menu/service/model/all_menu.dart';

import '../../../config/networking.dart';
import '../../login/service/model/list_menu.dart';
import '../../login/service/model/pin_menu_byrole.dart';

class MenuService {
  static deleteMenuFromRole(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    var jsonInput = jsonEncode(params);

    String url = 'menus/deleterolemenu';

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    GeneralResponse result = GeneralResponse.fromJson(decodedData);

    return result;
  }

  static addMenuToRole(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    var jsonInput = jsonEncode(params);

    String url = 'menus/addmenutorole';

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    GeneralResponse result = GeneralResponse.fromJson(decodedData);

    return result;
  }

  static getAllMenu(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? _token = prefs.getString('token');
    String url = 'menus';

    NetworkHelper networkHelper = NetworkHelper(url, '', _token!);

    Response response = await networkHelper.getRequest(context, url);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];
    List<AllMenu> result =
        collection.map((json) => AllMenu.fromJson(json)).toList();

    return result;
  }

  static getAllMenuByRole(context, _roleid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    PinMenuByRole params = PinMenuByRole(
      roleid: _roleid,
    );
    var jsonInput = jsonEncode(params);

    NetworkHelper networkHelper =
        NetworkHelper('menus/menubyrole', jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];
    List<ListMenu> result =
        collection.map((json) => ListMenu.fromJson(json)).toList();

    return result;
  }
}
