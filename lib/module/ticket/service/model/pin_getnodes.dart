// To parse this JSON data, do
//
//     final pinGetNodes = pinGetNodesFromJson(jsonString);

import 'dart:convert';

PinGetNodes pinGetNodesFromJson(String str) =>
    PinGetNodes.fromJson(json.decode(str));

String pinGetNodesToJson(PinGetNodes data) => json.encode(data.toJson());

class PinGetNodes {
  PinGetNodes({
    this.subkategoriId,
  });

  int? subkategoriId;

  factory PinGetNodes.fromJson(Map<String, dynamic> json) => PinGetNodes(
        subkategoriId: json["subkategoriId"],
      );

  Map<String, dynamic> toJson() => {
        "subkategoriId": subkategoriId,
      };
}
