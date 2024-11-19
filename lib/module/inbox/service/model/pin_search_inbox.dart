// To parse this JSON data, do
//
//     final pinSearchInbox = pinSearchInboxFromJson(jsonString);

import 'dart:convert';

PinSearchInbox pinSearchInboxFromJson(String str) =>
    PinSearchInbox.fromJson(json.decode(str));

String pinSearchInboxToJson(PinSearchInbox data) => json.encode(data.toJson());

class PinSearchInbox {
  PinSearchInbox({
    this.roleid,
    this.status,
    this.uid,
    this.bulan,
    this.ticketid,
  });

  String? roleid;
  String? status;
  String? uid;
  String? bulan;
  String? ticketid;

  factory PinSearchInbox.fromJson(Map<String, dynamic> json) => PinSearchInbox(
        roleid: json["roleid"],
        status: json["status"],
        uid: json["uid"],
        bulan: json["bulan"],
        ticketid: json["ticketid"],
      );

  Map<String, dynamic> toJson() => {
        "roleid": roleid,
        "status": status,
        "uid": uid,
        "bulan": bulan,
        "ticketid": ticketid,
      };
}
