// To parse this JSON data, do
//
//     final pinCheckPasport = pinCheckPasportFromJson(jsonString);

import 'dart:convert';

PinCheckPasport pinCheckPasportFromJson(String str) =>
    PinCheckPasport.fromJson(json.decode(str));

String pinCheckPasportToJson(PinCheckPasport data) =>
    json.encode(data.toJson());

class PinCheckPasport {
  PinCheckPasport({
    this.passportId,
  });

  String? passportId;

  factory PinCheckPasport.fromJson(Map<String, dynamic> json) =>
      PinCheckPasport(
        passportId: json["passportId"],
      );

  Map<String, dynamic> toJson() => {
        "passportId": passportId,
      };
}
