// To parse this JSON data, do
//
//     final responseCreateTicket = responseCreateTicketFromJson(jsonString);

import 'dart:convert';

ResponseCreateTicket responseCreateTicketFromJson(String str) =>
    ResponseCreateTicket.fromJson(json.decode(str));

String responseCreateTicketToJson(ResponseCreateTicket data) =>
    json.encode(data.toJson());

class ResponseCreateTicket {
  ResponseCreateTicket({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory ResponseCreateTicket.fromJson(Map<String, dynamic> json) =>
      ResponseCreateTicket(
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
