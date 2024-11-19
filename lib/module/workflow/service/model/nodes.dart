// To parse this JSON data, do
//
//     final nodes = nodesFromJson(jsonString);

import 'dart:convert';

List<Nodes> nodesFromJson(String str) =>
    List<Nodes>.from(json.decode(str).map((x) => Nodes.fromJson(x)));

String nodesToJson(List<Nodes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Nodes {
  Nodes({
    this.id,
    this.workflowName,
  });

  int? id;
  String? workflowName;

  factory Nodes.fromJson(Map<String, dynamic> json) => Nodes(
        id: json["id"],
        workflowName: json["workflow_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workflow_name": workflowName,
      };
}
