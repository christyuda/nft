// To parse this JSON data, do
//
//     final ticket = ticketFromJson(jsonString);

import 'dart:convert';

List<Ticket> ticketFromJson(String str) =>
    List<Ticket>.from(json.decode(str).map((x) => Ticket.fromJson(x)));

String ticketToJson(List<Ticket> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ticket {
  Ticket({
    this.createdAt,
    this.kategori,
    this.customerName,
    this.mobilePhone,
    this.categoryId,
    this.subcategoryId,
    this.keterangan,
    this.ticketId,
    this.ticketDetailId,
    this.workflowTypeId,
    this.workflowNodeId,
    this.statusname,
    this.statusId,
    this.sla,
    this.compensation,
    this.desc,
    this.sequence,
    this.nextSequence,
    this.solusi,
    this.userid,
  });

  String? createdAt;
  String? kategori;
  String? customerName;
  String? mobilePhone;
  int? categoryId;
  int? subcategoryId;
  String? keterangan;
  int? ticketId;
  int? ticketDetailId;
  int? workflowTypeId;
  int? workflowNodeId;
  String? statusname;
  int? statusId;
  int? sla;
  dynamic compensation;
  dynamic desc;
  int? sequence;
  int? nextSequence;
  dynamic solusi;
  dynamic userid;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        createdAt: json["created_at"],
        kategori: json["kategori"],
        customerName: json["customer_name"],
        mobilePhone: json["mobile_phone"],
        categoryId: json["category_id"],
        subcategoryId: json["subcategory_id"],
        keterangan: json["keterangan"],
        ticketId: json["ticket_id"],
        ticketDetailId: json["ticketDetailID"],
        workflowTypeId: json["workflow_type_id"],
        workflowNodeId: json["workflow_node_id"],
        statusname: json["statusname"],
        statusId: json["status_id"],
        sla: json["sla"],
        compensation: json["compensation"],
        desc: json["desc"],
        sequence: json["sequence"],
        nextSequence: json["next_sequence"],
        solusi: json["solusi"],
        userid: json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "kategori": kategori,
        "customer_name": customerName,
        "mobile_phone": mobilePhone,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "keterangan": keterangan,
        "ticket_id": ticketId,
        "ticketDetailID": ticketDetailId,
        "workflow_type_id": workflowTypeId,
        "workflow_node_id": workflowNodeId,
        "statusname": statusname,
        "status_id": statusId,
        "sla": sla,
        "compensation": compensation,
        "desc": desc,
        "sequence": sequence,
        "next_sequence": nextSequence,
        "solusi": solusi,
        "userid": userid,
      };
}
