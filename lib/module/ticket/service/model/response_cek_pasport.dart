// To parse this JSON data, do
//
//     final responseCheckPasport = responseCheckPasportFromJson(jsonString);

import 'dart:convert';

ResponseCheckPasport responseCheckPasportFromJson(String str) =>
    ResponseCheckPasport.fromJson(json.decode(str));

String responseCheckPasportToJson(ResponseCheckPasport data) =>
    json.encode(data.toJson());

class ResponseCheckPasport {
  ResponseCheckPasport({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  String? code;
  String? message;
  Data? data;

  factory ResponseCheckPasport.fromJson(Map<String, dynamic> json) =>
      ResponseCheckPasport(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.userId,
    this.passportId,
    this.userKindId,
    this.userKindName,
    this.fullName,
    this.identityNumber,
    this.birthPlace,
    this.birthDate,
    this.districtName,
    this.countryName,
  });

  String? userId;
  String? passportId;
  int? userKindId;
  String? userKindName;
  String? fullName;
  String? identityNumber;
  String? birthPlace;
  String? birthDate;
  String? districtName;
  String? countryName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"],
        passportId: json["passportId"],
        userKindId: json["userKindId"],
        userKindName: json["userKindName"],
        fullName: json["fullName"],
        identityNumber: json["identityNumber"],
        birthPlace: json["birthPlace"],
        birthDate: json["birthDate"],
        districtName: json["districtName"],
        countryName: json["countryName"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "passportId": passportId,
        "userKindId": userKindId,
        "userKindName": userKindName,
        "fullName": fullName,
        "identityNumber": identityNumber,
        "birthPlace": birthPlace,
        "birthDate": birthDate,
        "districtName": districtName,
        "countryName": countryName,
      };
}
