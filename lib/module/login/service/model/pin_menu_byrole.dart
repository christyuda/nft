// To parse this JSON data, do
//
//     final pinMenuByRole = pinMenuByRoleFromJson(jsonString);

import 'dart:convert';

PinMenuByRole pinMenuByRoleFromJson(String str) =>
    PinMenuByRole.fromJson(json.decode(str));

String pinMenuByRoleToJson(PinMenuByRole data) => json.encode(data.toJson());

class PinMenuByRole {
  PinMenuByRole({
    this.roleid,
  });

  String? roleid;

  factory PinMenuByRole.fromJson(Map<String, dynamic> json) => PinMenuByRole(
        roleid: json["roleid"],
      );

  Map<String, dynamic> toJson() => {
        "roleid": roleid,
      };
}
