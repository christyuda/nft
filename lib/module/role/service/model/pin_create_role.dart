// To parse this JSON data, do
//
//     final pinCreateRole = pinCreateRoleFromJson(jsonString);

import 'dart:convert';

PinCreateRole pinCreateRoleFromJson(String str) =>
    PinCreateRole.fromJson(json.decode(str));

String pinCreateRoleToJson(PinCreateRole data) => json.encode(data.toJson());

class PinCreateRole {
  PinCreateRole({
    required this.roleName,
    required this.desc,
  });

  String roleName;
  String desc;

  factory PinCreateRole.fromJson(Map<String, dynamic> json) => PinCreateRole(
        roleName: json["role_name"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "role_name": roleName,
        "desc": desc,
      };
}
