// To parse this JSON data, do
//
//     final generalResponse = generalResponseFromJson(jsonString);

import 'dart:convert';

GeneralResponse generalResponseFromJson(String str) =>
    GeneralResponse.fromJson(json.decode(str));

String generalResponseToJson(GeneralResponse data) =>
    json.encode(data.toJson());

class GeneralResponse {
  GeneralResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory GeneralResponse.fromJson(Map<String, dynamic> json) =>
      GeneralResponse(
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
