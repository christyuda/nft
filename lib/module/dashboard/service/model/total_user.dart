// To parse this JSON data, do
//
//     final totalUser = totalUserFromJson(jsonString);

import 'dart:convert';

List<TotalUser> totalUserFromJson(String str) =>
    List<TotalUser>.from(json.decode(str).map((x) => TotalUser.fromJson(x)));

String totalUserToJson(List<TotalUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TotalUser {
  TotalUser({
    this.identifier,
    this.total,
  });

  String? identifier;
  int? total;

  factory TotalUser.fromJson(Map<String, dynamic> json) => TotalUser(
        identifier: json["identifier"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "total": total,
      };
}
