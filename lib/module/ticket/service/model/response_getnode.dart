// To parse this JSON data, do
//
//     final responseGetNodes = responseGetNodesFromJson(jsonString);

import 'dart:convert';

ResponseGetNodes responseGetNodesFromJson(String str) =>
    ResponseGetNodes.fromJson(json.decode(str));

String responseGetNodesToJson(ResponseGetNodes data) =>
    json.encode(data.toJson());

class ResponseGetNodes {
  ResponseGetNodes({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory ResponseGetNodes.fromJson(Map<String, dynamic> json) =>
      ResponseGetNodes(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.wokflowid,
    this.nodes,
  });

  int? wokflowid;
  List<Node>? nodes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        wokflowid: json["wokflowid"],
        nodes: json["nodes"] == null
            ? []
            : List<Node>.from(json["nodes"]!.map((x) => Node.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "wokflowid": wokflowid,
        "nodes": nodes == null
            ? []
            : List<dynamic>.from(nodes!.map((x) => x.toJson())),
      };
}

class Node {
  Node({
    this.id,
    this.roleId,
    this.rolename,
  });

  int? id;
  int? roleId;
  String? rolename;

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        id: json["id"],
        roleId: json["role_id"],
        rolename: json["rolename"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "rolename": rolename,
      };
}
