// To parse this JSON data, do
//
//     final pinAmbilTiket = pinAmbilTiketFromJson(jsonString);

import 'dart:convert';

PinAmbilTiket pinAmbilTiketFromJson(String str) =>
    PinAmbilTiket.fromJson(json.decode(str));

String pinAmbilTiketToJson(PinAmbilTiket data) => json.encode(data.toJson());

class PinAmbilTiket {
  PinAmbilTiket({
    this.userid,
    this.ticketid,
    this.tickedetailstid,
    this.nextsequence,
  });

  String? userid;
  String? ticketid;
  String? tickedetailstid;
  String? nextsequence;

  factory PinAmbilTiket.fromJson(Map<String, dynamic> json) => PinAmbilTiket(
        userid: json["userid"],
        ticketid: json["ticketid"],
        tickedetailstid: json["tickedetailstid"],
        nextsequence: json["nextsequence"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "ticketid": ticketid,
        "tickedetailstid": tickedetailstid,
        "nextsequence": nextsequence,
      };
}
