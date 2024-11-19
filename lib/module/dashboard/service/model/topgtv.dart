// To parse this JSON data, do
//
//     final topGtv = topGtvFromJson(jsonString);

import 'dart:convert';

List<TopGtv> topGtvFromJson(String str) =>
    List<TopGtv>.from(json.decode(str).map((x) => TopGtv.fromJson(x)));

String topGtvToJson(List<TopGtv> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopGtv {
  TopGtv({
    this.domain,
    this.measure,
  });

  String? domain;
  double? measure;

  factory TopGtv.fromJson(Map<String, dynamic> json) => TopGtv(
        domain: json["domain"],
        measure: json["measure"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "domain": domain,
        "measure": measure,
      };
}
