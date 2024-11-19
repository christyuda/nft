// To parse this JSON data, do
//
//     final pinCreateTicket = pinCreateTicketFromJson(jsonString);

import 'dart:convert';

PinCreateTicket pinCreateTicketFromJson(String str) =>
    PinCreateTicket.fromJson(json.decode(str));

String pinCreateTicketToJson(PinCreateTicket data) =>
    json.encode(data.toJson());

class PinCreateTicket {
  PinCreateTicket({
    this.workflowid,
    this.categoryid,
    this.subcategoryid,
    this.srccomplaintid,
    this.keterangan,
    this.customername,
    this.mobilephone,
    this.tindakan,
    this.userid,
    this.customerid,
  });

  String? workflowid;
  String? categoryid;
  String? subcategoryid;
  int? srccomplaintid;
  int? tindakan;
  int? userid;
  String? keterangan;
  String? customername;
  String? mobilephone;
  String? customerid;

  factory PinCreateTicket.fromJson(Map<String, dynamic> json) =>
      PinCreateTicket(
        workflowid: json["workflowid"],
        categoryid: json["categoryid"],
        subcategoryid: json["subcategoryid"],
        srccomplaintid: json["srccomplaintid"],
        keterangan: json["keterangan"],
        customername: json["customername"],
        mobilephone: json["mobilephone"],
        tindakan: json["tindakan"],
        userid: json["userid"],
        customerid: json["customerid"],
      );

  Map<String, dynamic> toJson() => {
        "workflowid": workflowid,
        "categoryid": categoryid,
        "subcategoryid": subcategoryid,
        "srccomplaintid": srccomplaintid,
        "keterangan": keterangan,
        "customername": customername,
        "mobilephone": mobilephone,
        "tindakan": tindakan,
        "userid": userid,
        "customerid": customerid,
      };
}
