// To parse this JSON data, do
//
//     final allMenu = allMenuFromJson(jsonString);

import 'dart:convert';

List<AllMenu> allMenuFromJson(String str) =>
    List<AllMenu>.from(json.decode(str).map((x) => AllMenu.fromJson(x)));

String allMenuToJson(List<AllMenu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllMenu {
  AllMenu({
    this.id,
    this.menuId,
    this.parentid,
    this.namaMenu,
    this.icon,
    this.routesPage,
    this.submenu,
  });

  int? id;
  String? menuId;
  int? parentid;
  String? namaMenu;
  String? icon;
  String? routesPage;
  List<Submenu>? submenu;

  factory AllMenu.fromJson(Map<String, dynamic> json) => AllMenu(
        id: json["id"],
        menuId: json["menu_id"],
        parentid: json["parentid"],
        namaMenu: json["nama_menu"],
        icon: json["icon"],
        routesPage: json["routes_page"],
        submenu: json["submenu"] == null
            ? []
            : List<Submenu>.from(
                json["submenu"]!.map((x) => Submenu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "menu_id": menuId,
        "parentid": parentid,
        "nama_menu": namaMenu,
        "icon": icon,
        "routes_page": routesPage,
        "submenu": submenu == null
            ? []
            : List<dynamic>.from(submenu!.map((x) => x.toJson())),
      };
}

class Submenu {
  Submenu({
    this.id,
    this.menuId,
    this.parentId,
    this.namaMenu,
    this.icon,
    this.routesPage,
  });

  int? id;
  String? menuId;
  int? parentId;
  String? namaMenu;
  String? icon;
  String? routesPage;

  factory Submenu.fromJson(Map<String, dynamic> json) => Submenu(
        id: json["id"],
        menuId: json["menu_id"],
        parentId: json["parent_id"],
        namaMenu: json["nama_menu"],
        icon: json["icon"],
        routesPage: json["routes_page"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "menu_id": menuId,
        "parent_id": parentId,
        "nama_menu": namaMenu,
        "icon": icon,
        "routes_page": routesPage,
      };
}
