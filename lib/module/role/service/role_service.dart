import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widget/general_response.dart';
import '../../../config/networking.dart';

class RoleService {
  static submitCreateRole(context, param) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String jsonInput = jsonEncode(param);

    NetworkHelper networkHelper =
        NetworkHelper('roles/addrole', jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    GeneralResponse _result = GeneralResponse.fromJson(decodedData);

    return _result;
  }
}
