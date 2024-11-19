import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/common/provider/general_provider.dart';
import 'package:webordernft/common/widget/general_response.dart';
import 'package:webordernft/module/person/service/model/list_user.dart';
import 'package:webordernft/module/person/service/model/profile.dart';

import '../../role/service/model/list_role.dart';
import '../service/model/pin_create_user.dart';
import '../service/model/pin_search_users.dart';
import '../service/user_service.dart';

class UserProvider with ChangeNotifier {
  List<Role> _rolelist = [];
  List<Datum> _userlist = [];
  List<Profile> _profile = [];

  String? _namaUser;
  String? _emailUser;
  String? _password;
  String? _cpassword;
  String? _status = "1";
  String? _roleUser;
  bool? _isDisableCrtUsr = true;

  //paging
  int? _page = 1;
  int? _lastPage = 0;
  int? _totalRow;
  int? _fromRow;
  int? _toRow;
  int? _currentPage;

  //getter
  List<Role>? get rolelist => _rolelist;
  List<Datum> get userlist => _userlist;
  List<Profile> get profile => _profile;
  String? get namauser => _namaUser;
  String? get emailUser => _emailUser;
  String? get password => _password;
  String? get cpassword => _cpassword;
  String? get status => _status;
  String? get roleUser => _roleUser;

  //paging
  int? get page => _page;
  int? get lastPage => _lastPage;
  int? get totalRow => _totalRow;
  int? get fromRow => _fromRow;
  int? get toRow => _toRow;
  int? get currentPage => _currentPage;

  bool? get isDisableCrtUsr => _isDisableCrtUsr;

  // setter

  set isDisableCrtUsr(bool? val) {
    _isDisableCrtUsr = val!;
    notifyListeners();
  }

  set currentPage(int? val) {
    _currentPage = val!;
    notifyListeners();
  }

  set toRow(int? val) {
    _toRow = val!;
    notifyListeners();
  }

  set fromRow(int? val) {
    _fromRow = val!;
    notifyListeners();
  }

  set totalRow(int? val) {
    _totalRow = val!;
    notifyListeners();
  }

  set page(int? val) {
    _page = val!;
    notifyListeners();
  }

  set lastPage(int? val) {
    _lastPage = val!;
    notifyListeners();
  }

  set status(String? val) {
    _status = val!;
    notifyListeners();
  }

  set roleUser(String? val) {
    _roleUser = val!;
    notifyListeners();
  }

  set cpassword(String? val) {
    _cpassword = val!;
    notifyListeners();
  }

  set password(String? val) {
    _password = val!;
    notifyListeners();
  }

  set emailUser(String? val) {
    _emailUser = val!;
    notifyListeners();
  }

  set namaUser(String? val) {
    _namaUser = val!;
    notifyListeners();
  }

  set rolelist(List<Role>? val) {
    _rolelist = val!;
    notifyListeners();
  }

  set userlist(List<Datum> val) {
    _userlist = val;
    notifyListeners();
  }

  set profile(List<Profile> val) {
    _profile = val;
    notifyListeners();
  }

  // function

  submitCreateUserAccount(context, key) async {
    final genprov = Provider.of<GeneralProv>(context, listen: false);
    PinCreateUser pin = PinCreateUser(
      name: namauser,
      email: emailUser,
      password: password,
      cPassword: cpassword,
      roleId: roleUser.toString(),
    );

    GeneralResponse result =
        await UserService.submitCreateAkunUser(context, pin);

    if (result.status == true) {
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
      key.currentState.reset();
      isDisableCrtUsr = true;
    } else {
      isDisableCrtUsr = true;
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
    }
  }

  getRoleList(context) async {
    List<Role>? _role = await UserService.getRole(context);

    rolelist = _role;
    notifyListeners();
  }

  getlistuser(context) async {
    final genprov = Provider.of<GeneralProv>(context, listen: false);

    PinSearchUsers pin = PinSearchUsers(
      email: emailUser,
      role: roleUser,
      status: status,
    );

    Users _result = await UserService.getUser(context, page, pin);
    List<Datum>? _usr = _result.data!.data;
    userlist = _usr!;
    if (_usr.length > 0) {
      lastPage = _result.data!.lastPage;
      totalRow = _result.data!.total;
      fromRow = _result.data!.from;
      toRow = _result.data!.to;
      currentPage = _result.data!.currentPage;
    }

    notifyListeners();
    genprov.dissmisLoading();
  }

  nextPage(context, String action) async {
    final genprov = Provider.of<GeneralProv>(context, listen: false);
    genprov.isLoading();
    if (action == 'previous') {
      page = (currentPage! - 1);
      notifyListeners();
    }
    if (action == 'next') {
      page = (currentPage! + 1) > num.parse(lastPage.toString())
          ? lastPage
          : (currentPage! + 1);
      notifyListeners();
    }
    getlistuser(context);
  }

  getProfileUser(context) async {
    List<Profile> _profile = await UserService.getTesProfile(context);
    profile = _profile;

    notifyListeners();
  }

  clearFilter() {
    emailUser = '';
    roleUser = '';
    status = '';
    notifyListeners();
  }
}
