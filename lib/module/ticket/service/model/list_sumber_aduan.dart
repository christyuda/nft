// To parse this JSON data, do
//
//     final listSumberAduan = listSumberAduanFromJson(jsonString);

import 'dart:convert';

List<ListSumberAduan> listSumberAduanFromJson(String str) =>
    List<ListSumberAduan>.from(
        json.decode(str).map((x) => ListSumberAduan.fromJson(x)));

String listSumberAduanToJson(List<ListSumberAduan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListSumberAduan {
  ListSumberAduan({
    this.id,
    this.sumber,
  });

  int? id;
  String? sumber;

  factory ListSumberAduan.fromJson(Map<String, dynamic> json) =>
      ListSumberAduan(
        id: json["id"],
        sumber: json["sumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sumber": sumber,
      };
}
