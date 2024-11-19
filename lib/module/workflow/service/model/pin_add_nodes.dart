// To parse this JSON data, do
//
//     final pinAddNodes = pinAddNodesFromJson(jsonString);

import 'dart:convert';

PinAddNodes pinAddNodesFromJson(String str) =>
    PinAddNodes.fromJson(json.decode(str));

String pinAddNodesToJson(PinAddNodes data) => json.encode(data.toJson());

class PinAddNodes {
  PinAddNodes({
    this.workflowtypeid,
    this.roleid,
    this.sla,
    this.jobdesc,
  });

  String? workflowtypeid;
  String? roleid;
  String? sla;
  String? jobdesc;

  factory PinAddNodes.fromJson(Map<String, dynamic> json) => PinAddNodes(
        workflowtypeid: json["workflowtypeid"],
        roleid: json["roleid"],
        sla: json["sla"],
        jobdesc: json["jobdesc"],
      );

  Map<String, dynamic> toJson() => {
        "workflowtypeid": workflowtypeid,
        "roleid": roleid,
        "sla": sla,
        "jobdesc": jobdesc,
      };
}
