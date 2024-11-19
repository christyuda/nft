// To parse this JSON data, do
//
//     final pinTicketstatusmontly = pinTicketstatusmontlyFromJson(jsonString);

import 'dart:convert';

PinTicketstatusmontly pinTicketstatusmontlyFromJson(String str) =>
    PinTicketstatusmontly.fromJson(json.decode(str));

String pinTicketstatusmontlyToJson(PinTicketstatusmontly data) =>
    json.encode(data.toJson());

class PinTicketstatusmontly {
  PinTicketstatusmontly({
    this.month,
  });

  String? month;

  factory PinTicketstatusmontly.fromJson(Map<String, dynamic> json) =>
      PinTicketstatusmontly(
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
      };
}

class PinTicketDaily {
  PinTicketDaily({
    this.day,
  });

  String? day;

  factory PinTicketDaily.fromJson(Map<String, dynamic> json) => PinTicketDaily(
        day: json["day"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
      };
}
