// To parse this JSON data, do
//
//     final node = nodeFromJson(jsonString);

import 'dart:convert';

NodeLocal nodeFromJson(String str) => NodeLocal.fromJson(json.decode(str));

String nodeToJson(NodeLocal data) => json.encode(data.toJson());

class NodeLocal {
  NodeLocal({
    this.workflowtypeid,
    this.roleid,
    this.rolename,
    this.sla,
    this.jobdesc,
  });

  String? workflowtypeid;
  String? rolename;
  String? roleid;
  String? sla;
  String? jobdesc;

  factory NodeLocal.fromJson(Map<String, dynamic> json) => NodeLocal(
        workflowtypeid: json["workflowtypeid"],
        roleid: json["roleid"],
        sla: json["sla"],
        jobdesc: json["jobdesc"],
        rolename: json["rolename"],
      );

  Map<String, dynamic> toJson() => {
        "workflowtypeid": workflowtypeid,
        "roleid": roleid,
        "sla": sla,
        "jobdesc": jobdesc,
        "rolename": rolename,
      };
}
