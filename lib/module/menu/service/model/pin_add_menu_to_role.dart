// To parse this JSON data, do
//
//     final pinAddMenuTorole = pinAddMenuToroleFromJson(jsonString);

import 'dart:convert';

PinAddMenuTorole pinAddMenuToroleFromJson(String str) =>
    PinAddMenuTorole.fromJson(json.decode(str));

String pinAddMenuToroleToJson(PinAddMenuTorole data) =>
    json.encode(data.toJson());

class PinAddMenuTorole {
  PinAddMenuTorole({
    this.roleId,
    this.menuId,
    this.parentId,
  });

  String? roleId;
  String? menuId;
  String? parentId;

  factory PinAddMenuTorole.fromJson(Map<String, dynamic> json) =>
      PinAddMenuTorole(
        roleId: json["role_id"],
        menuId: json["menu_id"],
        parentId: json["parent_id"],
      );

  Map<String, dynamic> toJson() => {
        "role_id": roleId,
        "menu_id": menuId,
        "parent_id": parentId,
      };
}
