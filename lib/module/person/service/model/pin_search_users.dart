// To parse this JSON data, do
//
//     final pinSearchUsers = pinSearchUsersFromJson(jsonString);

import 'dart:convert';

PinSearchUsers pinSearchUsersFromJson(String str) =>
    PinSearchUsers.fromJson(json.decode(str));

String pinSearchUsersToJson(PinSearchUsers data) => json.encode(data.toJson());

class PinSearchUsers {
  PinSearchUsers({
    this.role,
    this.email,
    this.status,
  });

  String? role;
  String? email;
  String? status;

  factory PinSearchUsers.fromJson(Map<String, dynamic> json) => PinSearchUsers(
        role: json["role"],
        email: json["email"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "email": email,
        "status": status,
      };
}
