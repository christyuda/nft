import 'package:flutter/material.dart';
import 'package:webordernft/module/dashboard/view/index_dashboard.dart';

import '../../../config/constant.dart';
import '../../../config/menu_setup.dart';

class MainProvider with ChangeNotifier {
  int? _selectedIndex = 0;
  List<Menus> _menu = [];
  String? _namaMenu = companyname;
  bool _isMenuOpen = true;
  // Widget? _pages = LoginLanding();
  Widget? _pages = DashboardScreen();

  // getter
  int? get selectedIndex => _selectedIndex;
  List<Menus> get menus => _menu;
  Widget? get pages => _pages;
  String? get namaMenu => _namaMenu;
  bool get isMenuOpen => _isMenuOpen;

  //setter
  set namaMenu(String? val) {
    _namaMenu = val;
    notifyListeners();
  }

  set pages(Widget? val) {
    _pages = val;
    notifyListeners();
  }

  set menus(List<Menus> val) {
    _menu = val;
    notifyListeners();
  }

  set selectedIndex(int? val) {
    _selectedIndex = val;
    notifyListeners();
  }

  void toggleMenu() {
    _isMenuOpen = !_isMenuOpen;
    notifyListeners();
  }
  // function
}
