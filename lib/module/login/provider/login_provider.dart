import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webordernft/config/auto_logout_service.dart';
import 'package:webordernft/module/login/service/model/pin_logout.dart';
import 'package:webordernft/module/login/service/model/profile.dart';

import '../../../common/provider/general_provider.dart';
import '../../../config/env.dart';
import '../service/login_service.dart';
import '../service/model/pin_login.dart';
import '../service/model/pin_profile.dart';
import '../service/model/response_login.dart';
import '../service/model/response_logout.dart';

class LoginProvider with ChangeNotifier {
  final AuthService _authservice = AuthService();
  String? _pinemail = '';
  String? _pinpassword = '';
  String _apiEndPoint = BASE_URL + API_ENDPOINT;
  String? _token = '';
  int? _roleid;
  int? _userid;

  String? get pinemail => _pinemail;
  String? get pinpassword => _pinpassword;
  String? get apiEndPoint => _apiEndPoint;
  String? get token => _token;
  int? get roleid => _roleid;
  int? get userid => _userid;

  set userid(int? val) {
    _userid = val!;
    notifyListeners();
  }

  set roleid(int? val) {
    _roleid = val!;
    notifyListeners();
  }

  set token(String? val) {
    _token = val;
    notifyListeners();
  }

  set apiEndPoint(String? val) {
    _apiEndPoint = val!;
    notifyListeners();
  }

  set pinemail(String? val) {
    _pinemail = val;
    notifyListeners();
  }

  set pinpassword(String? val) {
    _pinpassword = val;
    notifyListeners();
  }

  // function
  Future<void> loginWithPresetCredentials(BuildContext context) async {
    final PinLogin params = PinLogin(
      email: 'wibowoeka155@gmail.com',
      password: '111111',
    );

    ResponseLogin response =
        await LoginService.submitLoginCredentials(context, params);

    if (response.status == true) {
      // Store token in the provider
      token = response.data!.token!;
      roleid = response.data!.roleId;
      userid = response.data!.userId;
    } else {
      throw Exception('Login failed');
    }
  }

  Future<void> submitlogin(BuildContext context) async {
    final genprov = Provider.of<GeneralProv>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    PinLogin params = PinLogin(
      email: pinemail,
      password: pinpassword,
    );

    ResponseLogin response = await LoginService.submitLogin(context, params);

    String msgError =
        'Username atau Password salah! Pastikan akun Anda terdaftar';

    if (response.status == true) {
      token = response.data!.token;
      roleid = response.data!.roleId;
      userid = response.data!.userId;
      notifyListeners();

      await prefs.setInt('roleid', response.data!.roleId!);
      await prefs.setString('token', response.data!.token!);
      await prefs.setInt('userid', response.data!.userId!);

      PinProfile params = PinProfile(
        uid: response.data!.userId.toString(),
      );

      ProfileLogin result = await LoginService.getProfileUser(context, params);
      await prefs.setString('rolename', result.data!.rolename!);
      await prefs.setString('name', result.data!.name!);

      genprov.dissmisLoading();
      notifyListeners();

      if (result.status == true) {
        notifyListeners();

        Navigator.pushNamedAndRemoveUntil(
            context, 'MainDashboard', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, '/backoffice', (route) => false);
      }
    } else {
      // Tampilkan pesan error jika login gagal
      genprov.dissmisLoading();
      genprov.message = msgError;
      genprov.genSendMessage();
    }

    notifyListeners();
  }

  Future<void> checkLoginStatus(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');
    String? rolename = prefs.getString('rolename');

    if (storedToken != null && rolename != null) {
      Navigator.pushNamedAndRemoveUntil(
          context, 'MainDashboard', (route) => false);
    }
  }

  submitLogout(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? _userid = prefs.getInt('userid');
    PinLogout params = PinLogout(
      userid: _userid,
    );

    ResponseLogout response = await LoginService.submitLogout(context, params);

    if (response.status == true) {
      Navigator.pushNamedAndRemoveUntil(
          context, 'LoginLanding', (route) => false);
    }
    prefs.clear();
  }
}
