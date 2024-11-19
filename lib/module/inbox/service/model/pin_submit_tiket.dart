// To parse this JSON data, do
//
//     final pinSubmitTiket = pinSubmitTiketFromJson(jsonString);

import 'dart:convert';

PinSubmitTiket pinSubmitTiketFromJson(String str) =>
    PinSubmitTiket.fromJson(json.decode(str));

String pinSubmitTiketToJson(PinSubmitTiket data) => json.encode(data.toJson());

class PinSubmitTiket {
  PinSubmitTiket({
    this.userid,
    this.ticketid,
    this.ticketdetailstid,
    this.nextsequence,
    this.wfstatus,
    this.desc,
    this.compensation,
    this.solusi,
  });

  String? userid;
  String? ticketid;
  String? ticketdetailstid;
  String? nextsequence;
  String? wfstatus;
  String? desc;
  String? compensation;
  String? solusi;

  factory PinSubmitTiket.fromJson(Map<String, dynamic> json) => PinSubmitTiket(
        userid: json["userid"],
        ticketid: json["ticketid"],
        ticketdetailstid: json["ticketdetailstid"],
        nextsequence: json["nextsequence"],
        wfstatus: json["wfstatus"],
        desc: json["desc"],
        compensation: json["compensation"],
        solusi: json["solusi"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "ticketid": ticketid,
        "ticketdetailstid": ticketdetailstid,
        "nextsequence": nextsequence,
        "wfstatus": wfstatus,
        "desc": desc,
        "compensation": compensation,
        "solusi": solusi,
      };
}
