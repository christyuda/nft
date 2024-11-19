// To parse this JSON data, do
//
//     final ticketstatusmontly = ticketstatusmontlyFromJson(jsonString);

import 'dart:convert';

List<Ticketstatusmontly> ticketstatusmontlyFromJson(String str) =>
    List<Ticketstatusmontly>.from(
        json.decode(str).map((x) => Ticketstatusmontly.fromJson(x)));

String ticketstatusmontlyToJson(List<Ticketstatusmontly> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ticketstatusmontly {
  Ticketstatusmontly({this.status, this.jumlah});

  String? status;
  String? jumlah;

  factory Ticketstatusmontly.fromJson(Map<String, dynamic> json) =>
      Ticketstatusmontly(
        status: json["status"] == null ? '0' : json["status"],
        jumlah: json["jumlah"] == null ? '0' : json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "jumlah": jumlah,
      };
}
