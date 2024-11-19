import 'dart:convert';

import 'package:flutter/material.dart';

// To parse this JSON data, do
//
//     final menus = menusFromJson(jsonString);

Menus menusFromJson(String str) => Menus.fromJson(json.decode(str));

String menusToJson(Menus data) => json.encode(data.toJson());

class Menus {
  Menus({
    this.kodemenu,
    this.namamenu,
    this.icon,
    this.submenu,
    this.page,
  });

  String? kodemenu;
  String? namamenu;
  IconData? icon;
  Widget? page;
  List<Submenu>? submenu;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        kodemenu: json["kodemenu"],
        namamenu: json["namamenu"],
        page: json["page"],
        icon: json["icon"],
        submenu: json["submenu"] == null
            ? []
            : List<Submenu>.from(
                json["submenu"]!.map((x) => Submenu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kodemenu": kodemenu,
        "namamenu": namamenu,
        "page": page,
        "icon": icon,
        "submenu": submenu == null
            ? []
            : List<dynamic>.from(submenu!.map((x) => x.toJson())),
      };
}

class Submenu {
  Submenu({
    this.kodesubmenu,
    this.namasubmenu,
    this.iconSubmenu,
    this.page,
  });

  String? kodesubmenu;
  String? namasubmenu;
  IconData? iconSubmenu;
  Widget? page;

  factory Submenu.fromJson(Map<String, dynamic> json) => Submenu(
        kodesubmenu: json["kodesubmenu"],
        namasubmenu: json["namasubmenu"],
        iconSubmenu: json["iconSubmenu"],
      );

  Map<String, dynamic> toJson() => {
        "kodesubmenu": kodesubmenu,
        "namasubmenu": namasubmenu,
        "iconSubmenu": iconSubmenu,
      };
}
//
// List<Menus> menuSetup = [
//   // Menus(
//   //   kodemenu: 'XX',
//   //   namamenu: 'Main Menu',
//   //   icon: Icons.dashboard_outlined,
//   //   page: DashboardScreen(),
//   //   submenu: [],
//   // ),
//   Menus(
//     kodemenu: 'A',
//     namamenu: 'Dashboard',
//     icon: Icons.dashboard_outlined,
//     submenu: [
//       Submenu(
//         kodesubmenu: 'A1',
//         namasubmenu: 'Dashboard All ',
//         iconSubmenu: Icons.dashboard_outlined,
//         page: DashboardScreen(),
//       ),
//       Submenu(
//         kodesubmenu: 'A2',
//         namasubmenu: 'Dashboard A2 ',
//         iconSubmenu: Icons.dashboard_outlined,
//         page: DashboardScreen(),
//       ),
//       Submenu(
//         kodesubmenu: 'A3',
//         namasubmenu: 'Dashboard A3 ',
//         iconSubmenu: Icons.dashboard_outlined,
//         page: DashboardScreen(),
//       ),
//     ],
//   ),
//   Menus(
//     kodemenu: 'B',
//     namamenu: 'User Management',
//     icon: Icons.dashboard_outlined,
//     submenu: [
//       Submenu(
//         kodesubmenu: 'B1',
//         namasubmenu: 'List User',
//         iconSubmenu: Icons.dashboard_outlined,
//         page: FormListUser(),
//       ),
//       Submenu(
//         kodesubmenu: 'B1',
//         namasubmenu: 'Dashboard B2 ',
//         iconSubmenu: Icons.dashboard_outlined,
//         page: DashboardScreen(),
//       ),
//       Submenu(
//         kodesubmenu: 'B3',
//         namasubmenu: 'Dashboard B3 ',
//         iconSubmenu: Icons.dashboard_outlined,
//         page: DashboardScreen(),
//       ),
//     ],
//   ),
// ];
