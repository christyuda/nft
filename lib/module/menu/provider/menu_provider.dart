import 'dart:developer' as logprint;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/module/menu/service/menu_service.dart';

import '../../../common/provider/general_provider.dart';
import '../../../common/widget/general_response.dart';
import '../../login/service/model/list_menu.dart';
import '../../person/service/user_service.dart';
import '../../role/service/model/list_role.dart';
import '../service/model/all_menu.dart';
import '../service/model/pin_add_menu_to_role.dart';
import '../service/model/pin_delete_menu.dart';

class MenuProvider with ChangeNotifier {
  List<AllMenu> _allmenu = [];
  List<ListMenu> _rolemenu = [];
  List<Role> _rolelist = [];
  String? _roleid;

  List<AllMenu> get allmenu => _allmenu;
  List<ListMenu> get rolemenu => _rolemenu;
  List<Role> get rolelist => _rolelist;
  String? get roleid => _roleid;

  set roleid(String? val) {
    _roleid = val;
    notifyListeners();
  }

  set allmenu(List<AllMenu> val) {
    _allmenu = val;
    notifyListeners();
  }

  set rolelist(List<Role> val) {
    _rolelist = val;
    notifyListeners();
  }

  set rolemenu(List<ListMenu> val) {
    _rolemenu = val;
    notifyListeners();
  }

  submitMenuToRole(context, _parentId, _menuId) async {
    final genprov = Provider.of<GeneralProv>(context, listen: false);

    PinAddMenuTorole params = PinAddMenuTorole(
      roleId: roleid!,
      parentId: _parentId.toString(),
      menuId: _menuId.toString(),
    );

    logprint.log(params.toString(), name: 'Parameter Add menu To Role');

    GeneralResponse result = await MenuService.addMenuToRole(context, params);

    if (result.status == true) {
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
      getAllmenuByRole(context);
    } else {
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
    }
  }

  deleteMenuFromRole(context, idrolemenu, _parentid) async {
    final genprov = Provider.of<GeneralProv>(context, listen: false);

    PinDeleteMenuFromRole params = PinDeleteMenuFromRole(
      menuId: idrolemenu.toString(),
      parentid: _parentid.toString(),
      roleid: roleid.toString(),
    );

    logprint.log(params.toString(), name: 'Parameter delete menu To Role');

    GeneralResponse result =
        await MenuService.deleteMenuFromRole(context, params);

    if (result.status == true) {
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
      getAllmenuByRole(context);
    } else {
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
    }
  }

  getAllMenu(context) async {
    List<AllMenu> _allmenu = await MenuService.getAllMenu(context);

    allmenu = _allmenu;
    notifyListeners();
  }

  getAllmenuByRole(context) async {
    List<ListMenu> _allmenu =
        await MenuService.getAllMenuByRole(context, roleid);

    rolemenu = _allmenu;
    notifyListeners();
  }

  getRoleList(context) async {
    List<Role> _role = await UserService.getRole(context);

    rolelist = _role;
    notifyListeners();
  }
}
