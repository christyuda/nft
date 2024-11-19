// To parse this JSON data, do
//
//     final dailyTicket = dailyTicketFromJson(jsonString);

import 'dart:convert';

List<DailyTicket> dailyTicketFromJson(String str) => List<DailyTicket>.from(
    json.decode(str).map((x) => DailyTicket.fromJson(x)));

String dailyTicketToJson(List<DailyTicket> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DailyTicket {
  DailyTicket({
    this.status,
    this.jumlah,
  });

  String? status;
  int? jumlah;

  factory DailyTicket.fromJson(Map<String, dynamic> json) => DailyTicket(
        status: json["status"],
        jumlah: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "jumlah": jumlah,
      };
}
