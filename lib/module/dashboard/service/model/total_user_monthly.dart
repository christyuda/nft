// To parse this JSON data, do
//
//     final totalUserMontly = totalUserMontlyFromJson(jsonString);

import 'dart:convert';

List<TotalUserMontly> totalUserMontlyFromJson(String str) =>
    List<TotalUserMontly>.from(
        json.decode(str).map((x) => TotalUserMontly.fromJson(x)));

String totalUserMontlyToJson(List<TotalUserMontly> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TotalUserMontly {
  TotalUserMontly({
    this.id,
    this.data,
  });

  String? id;
  List<Datum>? data;

  factory TotalUserMontly.fromJson(Map<String, dynamic> json) =>
      TotalUserMontly(
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

  int? domain;
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
