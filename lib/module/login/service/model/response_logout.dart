// To parse this JSON data, do
//
//     final responseLogout = responseLogoutFromJson(jsonString);

import 'dart:convert';

ResponseLogout responseLogoutFromJson(String str) =>
    ResponseLogout.fromJson(json.decode(str));

String responseLogoutToJson(ResponseLogout data) => json.encode(data.toJson());

class ResponseLogout {
  ResponseLogout({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory ResponseLogout.fromJson(Map<String, dynamic> json) => ResponseLogout(
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
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
