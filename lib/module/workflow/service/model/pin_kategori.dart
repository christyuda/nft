// To parse this JSON data, do
//
//     final pinKategori = pinKategoriFromJson(jsonString);

import 'dart:convert';

PinKategori pinKategoriFromJson(String str) =>
    PinKategori.fromJson(json.decode(str));

String pinKategoriToJson(PinKategori data) => json.encode(data.toJson());

class PinKategori {
  PinKategori({
    this.namaSubkategori,
    this.description,
    this.parentId,
    this.code,
    this.type,
  });

  String? namaSubkategori;
  String? description;
  String? parentId;
  String? code;
  String? type;

  factory PinKategori.fromJson(Map<String, dynamic> json) => PinKategori(
        namaSubkategori: json["nama_subkategori"],
        description: json["description"],
        parentId: json["parent_id"],
        code: json["code"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "nama_subkategori": namaSubkategori,
        "description": description,
        "parent_id": parentId,
        "code": code,
        "type": type,
      };
}
