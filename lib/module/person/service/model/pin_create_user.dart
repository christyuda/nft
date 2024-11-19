// To parse this JSON data, do
//
//     final pinCreateUser = pinCreateUserFromJson(jsonString);

import 'dart:convert';

PinCreateUser pinCreateUserFromJson(String str) =>
    PinCreateUser.fromJson(json.decode(str));

String pinCreateUserToJson(PinCreateUser data) => json.encode(data.toJson());

class PinCreateUser {
  PinCreateUser({
    this.name,
    this.email,
    this.password,
    this.cPassword,
    this.roleId,
  });

  String? name;
  String? email;
  String? password;
  String? cPassword;
  String? roleId;

  factory PinCreateUser.fromJson(Map<String, dynamic> json) => PinCreateUser(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        cPassword: json["c_password"],
        roleId: json["role_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "c_password": cPassword,
        "role_id": roleId,
      };
}
