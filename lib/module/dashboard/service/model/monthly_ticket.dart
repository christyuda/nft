// To parse this JSON data, do
//
//     final montlyTicket = montlyTicketFromJson(jsonString);

import 'dart:convert';

List<MontlyTicket> montlyTicketFromJson(String str) => List<MontlyTicket>.from(
    json.decode(str).map((x) => MontlyTicket.fromJson(x)));

String montlyTicketToJson(List<MontlyTicket> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MontlyTicket {
  MontlyTicket({
    this.id,
    this.data,
  });

  String? id;
  List<Datum>? data;

  factory MontlyTicket.fromJson(Map<String, dynamic> json) => MontlyTicket(
        id: json["id"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.domain,
    this.measure,
  });

  dynamic? domain;
  int? measure;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        domain: json["domain"],
        measure: json["measure"],
      );

  Map<String, dynamic> toJson() => {
        "domain": domain,
        "measure": measure,
      };
}
