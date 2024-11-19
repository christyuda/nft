// To parse this JSON data, do
//
//     final pinLogin = pinLoginFromJson(jsonString);

import 'dart:convert';

PinLogin pinLoginFromJson(String str) => PinLogin.fromJson(json.decode(str));

String pinLoginToJson(PinLogin data) => json.encode(data.toJson());

class PinLogin {
  PinLogin({
    this.email,
    this.password,
  });

  String? email;
  String? password;

  factory PinLogin.fromJson(Map<String, dynamic> json) => PinLogin(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
