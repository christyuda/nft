// To parse this JSON data, do
//
//     final responseLogin = responseLoginFromJson(jsonString);

import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) =>
    ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  ResponseLogin({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
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
    this.token,
    this.roleId,
    this.userId,
  });

  String? token;
  int? roleId;
  int? userId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"] == null ? '' : json["token"],
        roleId: json["role_id"] == null ? 0 : json["role_id"],
        userId: json["user_id"] == null ? 0 : json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "role_id": roleId,
        "user_id": userId,
      };
}

// class DataLogin {
//   DataLogin({
//     required this.token,
//     required this.fcmToken,
//     required this.secretKey,
//   });
//
//   String token;
//   String fcmToken;
//   String secretKey;
//
//   factory DataLogin.fromJson(Map<String, dynamic> json) => DataLogin(
//         token: json["token"] == null ? '' : json["token"],
//         fcmToken: json["fcmToken"] == null ? '' : json["fcmToken"],
//         secretKey: json["secretKey"] == null ? '' : json["secretKey"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "token": token == null ? '' : token,
//         "fcmToken": fcmToken == null ? '' : fcmToken,
//         "secretKey": secretKey == null ? '' : secretKey,
//       };
// }
