// To parse this JSON data, do
//
//     final pinSubmitMapping = pinSubmitMappingFromJson(jsonString);

import 'dart:convert';

PinSubmitMapping pinSubmitMappingFromJson(String str) =>
    PinSubmitMapping.fromJson(json.decode(str));

String pinSubmitMappingToJson(PinSubmitMapping data) =>
    json.encode(data.toJson());

class PinSubmitMapping {
  PinSubmitMapping({
    this.categoryid,
    this.workflowtypeid,
  });

  String? categoryid;
  String? workflowtypeid;

  factory PinSubmitMapping.fromJson(Map<String, dynamic> json) =>
      PinSubmitMapping(
        categoryid: json["categoryid"],
        workflowtypeid: json["workflowtypeid"],
      );

  Map<String, dynamic> toJson() => {
        "categoryid": categoryid,
        "workflowtypeid": workflowtypeid,
      };
}
