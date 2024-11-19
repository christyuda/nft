// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

ProfileLogin profileFromJson(String str) =>
    ProfileLogin.fromJson(json.decode(str));

String profileToJson(ProfileLogin data) => json.encode(data.toJson());

class ProfileLogin {
  ProfileLogin({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory ProfileLogin.fromJson(Map<String, dynamic> json) => ProfileLogin(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.roleId,
    this.rolename,
    this.name,
  });

  int? id;
  int? roleId;
  String? rolename;
  String? name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        roleId: json["role_id"],
        rolename: json["rolename"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "rolename": rolename,
        "name": name,
      };
}
