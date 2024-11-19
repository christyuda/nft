// To parse this JSON data, do
//
//     final totalUserCountryMontly = totalUserCountryMontlyFromJson(jsonString);

import 'dart:convert';

List<TotalUserCountryMontly> totalUserCountryMontlyFromJson(String str) =>
    List<TotalUserCountryMontly>.from(
        json.decode(str).map((x) => TotalUserCountryMontly.fromJson(x)));

String totalUserCountryMontlyToJson(List<TotalUserCountryMontly> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TotalUserCountryMontly {
  TotalUserCountryMontly({
    this.id,
    this.data,
  });

  String? id;
  List<Datum>? data;

  factory TotalUserCountryMontly.fromJson(Map<String, dynamic> json) =>
      TotalUserCountryMontly(
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

  String? domain;
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
