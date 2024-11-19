// To parse this JSON data, do
//
//     final pinDeleteMenuFromRole = pinDeleteMenuFromRoleFromJson(jsonString);

import 'dart:convert';

PinDeleteMenuFromRole pinDeleteMenuFromRoleFromJson(String str) =>
    PinDeleteMenuFromRole.fromJson(json.decode(str));

String pinDeleteMenuFromRoleToJson(PinDeleteMenuFromRole data) =>
    json.encode(data.toJson());

class PinDeleteMenuFromRole {
  PinDeleteMenuFromRole({
    this.menuId,
    this.parentid,
    this.roleid,
  });

  String? menuId;
  String? parentid;
  String? roleid;

  factory PinDeleteMenuFromRole.fromJson(Map<String, dynamic> json) =>
      PinDeleteMenuFromRole(
        menuId: json["role_menu_id"],
        parentid: json["parentid"],
        roleid: json["roleid"],
      );

  Map<String, dynamic> toJson() => {
        "role_menu_id": menuId,
        "parentid": parentid,
        "roleid": roleid,
      };
}
