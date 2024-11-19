// To parse this JSON data, do
//
//     final pinWorkflowType = pinWorkflowTypeFromJson(jsonString);

import 'dart:convert';

PinWorkflowType pinWorkflowTypeFromJson(String str) =>
    PinWorkflowType.fromJson(json.decode(str));

String pinWorkflowTypeToJson(PinWorkflowType data) =>
    json.encode(data.toJson());

class PinWorkflowType {
  PinWorkflowType({
    this.kategoriId,
    this.subkategoriId,
    this.workflowName,
    this.slg,
    this.desc,
  });

  String? kategoriId;
  String? subkategoriId;
  String? workflowName;
  String? slg;
  String? desc;

  factory PinWorkflowType.fromJson(Map<String, dynamic> json) =>
      PinWorkflowType(
        kategoriId: json["kategori_id"],
        subkategoriId: json["subkategori_id"],
        workflowName: json["workflow_name"],
        slg: json["slg"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "kategori_id": kategoriId,
        "subkategori_id": subkategoriId,
        "workflow_name": workflowName,
        "slg": slg,
        "desc": desc,
      };
}
