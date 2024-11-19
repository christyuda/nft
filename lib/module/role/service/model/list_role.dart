// To parse this JSON data, do
//
//     final listRole = listRoleFromJson(jsonString);

import 'dart:convert';

List<Role> listRoleFromJson(String str) =>
    List<Role>.from(json.decode(str).map((x) => Role.fromJson(x)));

String listRoleToJson(List<Role> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Role {
  Role({
    this.id,
    this.roleId,
    this.rolename,
    this.desc,
  });

  int? id;
  int? roleId;
  String? rolename;
  String? desc;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        roleId: json["role_id"],
        rolename: json["rolename"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "rolename": rolename,
        "desc": desc,
      };
}
