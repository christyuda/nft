import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/provider/general_provider.dart';
import '../../../common/widget/general_response.dart';
import '../service/model/pin_create_role.dart';
import '../service/role_service.dart';

class RoleProvider with ChangeNotifier {
  bool? _isDisableCrtRole = true;
  String? _rolename;
  String? _deskripsi;

  bool? get isDisableCrtRole => _isDisableCrtRole;
  String? get rolename => _rolename;
  String? get deskripsi => _deskripsi;

  set deskripsi(String? val) {
    _deskripsi = val!;
    notifyListeners();
  }

  set rolename(String? val) {
    _rolename = val!;
    notifyListeners();
  }

  set isDisableCrtRole(bool? val) {
    _isDisableCrtRole = val!;
    notifyListeners();
  }

  // function
  submitCreateRole(context, key) async {
    final genprov = Provider.of<GeneralProv>(context, listen: false);
    PinCreateRole pin = PinCreateRole(
      roleName: rolename!,
      desc: deskripsi!,
    );

    GeneralResponse result = await RoleService.submitCreateRole(context, pin);

    if (result.status == true) {
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
      key.currentState.reset();
      isDisableCrtRole = true;
    } else {
      isDisableCrtRole = true;
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
    }
  }
}
