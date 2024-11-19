// To parse this JSON data, do
//
//     final ticketPagination = ticketPaginationFromJson(jsonString);

import 'dart:convert';

TicketPagination ticketPaginationFromJson(String str) =>
    TicketPagination.fromJson(json.decode(str));

String ticketPaginationToJson(TicketPagination data) =>
    json.encode(data.toJson());

class TicketPagination {
  TicketPagination({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory TicketPagination.fromJson(Map<String, dynamic> json) =>
      TicketPagination(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<DatumTicket>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"] == null ? 0 : json["current_page"],
        data: json["data"] == null
            ? []
            : List<DatumTicket>.from(
                json["data"]!.map((x) => DatumTicket.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"] == null ? 0 : json["from"],
        lastPage: json["last_page"] == null ? 0 : json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"] == null ? 0 : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? 0 : json["to"],
        total: json["total"] == null ? 0 : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class DatumTicket {
  DatumTicket({
    this.rownum,
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
  int? rownum;
  DateTime? createdAt;
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

  factory DatumTicket.fromJson(Map<String, dynamic> json) => DatumTicket(
        rownum: json["rownum"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
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
        "created_at": createdAt?.toIso8601String(),
        "rownum": rownum,
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

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
