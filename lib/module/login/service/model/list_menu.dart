// To parse this JSON data, do
//
//     final listMenu = listMenuFromJson(jsonString);

import 'dart:convert';

List<ListMenu> listMenuFromJson(String str) =>
    List<ListMenu>.from(json.decode(str).map((x) => ListMenu.fromJson(x)));

String listMenuToJson(List<ListMenu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListMenu {
  ListMenu({
    this.id,
    this.roleId,
    this.menuId,
    this.parentid,
    this.namaMenu,
    this.icon,
    this.routesPage,
    this.submenu,
  });

  int? id;
  int? roleId;
  int? menuId;
  int? parentid;
  String? namaMenu;
  String? icon;
  String? routesPage;
  List<ListMenu>? submenu;

  factory ListMenu.fromJson(Map<String, dynamic> json) => ListMenu(
        id: json["id"],
        roleId: json["role_id"],
        menuId: json["menu_id"],
        parentid: json["parentid"],
        namaMenu: json["nama_menu"],
        icon: json["icon"],
        routesPage: json["routes_page"],
        submenu: json["submenu"] == null
            ? []
            : List<ListMenu>.from(
                json["submenu"]!.map((x) => ListMenu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
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
