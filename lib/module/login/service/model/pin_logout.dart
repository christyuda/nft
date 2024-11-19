// To parse this JSON data, do
//
//     final pinLogout = pinLogoutFromJson(jsonString);

import 'dart:convert';

PinLogout pinLogoutFromJson(String str) => PinLogout.fromJson(json.decode(str));

String pinLogoutToJson(PinLogout data) => json.encode(data.toJson());

class PinLogout {
  PinLogout({
    this.userid,
  });

  int? userid;

  factory PinLogout.fromJson(Map<String, dynamic> json) => PinLogout(
        userid: json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
      };
}
