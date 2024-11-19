// To parse this JSON data, do
//
//     final listKategori = listKategoriFromJson(jsonString);

import 'dart:convert';

List<ListKategori> listKategoriFromJson(String str) => List<ListKategori>.from(
    json.decode(str).map((x) => ListKategori.fromJson(x)));

String listKategoriToJson(List<ListKategori> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListKategori {
  ListKategori({
    this.id,
    this.name,
    this.desc,
    this.parentId,
    this.code,
  });

  int? id;
  String? name;
  String? desc;
  int? parentId;
  String? code;

  factory ListKategori.fromJson(Map<String, dynamic> json) => ListKategori(
        id: json["id"] == null ? 0 : json["id"],
        name: json["name"] == null ? '' : json["name"],
        desc: json["desc"] == null ? '' : json["desc"],
        parentId: json["parent_id"] == null ? 0 : json["parent_id"],
        code: json["code"] == null ? 0 : json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "desc": desc,
        "parent_id": parentId,
        "code": code,
      };
}
