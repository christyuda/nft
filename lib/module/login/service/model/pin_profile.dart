// To parse this JSON data, do
//
//     final pinProfile = pinProfileFromJson(jsonString);

import 'dart:convert';

PinProfile pinProfileFromJson(String str) =>
    PinProfile.fromJson(json.decode(str));

String pinProfileToJson(PinProfile data) => json.encode(data.toJson());

class PinProfile {
  PinProfile({
    this.uid,
  });

  String? uid;

  factory PinProfile.fromJson(Map<String, dynamic> json) => PinProfile(
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
      };
}
