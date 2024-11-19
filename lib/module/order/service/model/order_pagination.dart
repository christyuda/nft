import 'dart:convert';
import 'package:webordernft/module/order/service/model/order_list.dart';

OrderPagination orderPaginationFromJson(String str) =>
    OrderPagination.fromJson(json.decode(str));

String orderPaginationToJson(OrderPagination data) =>
    json.encode(data.toJson());

class OrderPagination {
  OrderPagination({
    this.currentPage,
    this.orderData,
    this.from,
    this.lastPage,
    this.total,
    this.to,
    this.firstPageUrl,
    this.lastPageUrl,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  int? currentPage;
  List<OrderData>? orderData; // List of OrderData
  int? from;
  int? lastPage;
  int? total;
  int? to;
  String? firstPageUrl;
  String? lastPageUrl;
  String? nextPageUrl;
  String? prevPageUrl;

  factory OrderPagination.fromJson(Map<String, dynamic> json) =>
      OrderPagination(
        currentPage: json["current_page"],
        orderData: json["data"] != null
            ? List<OrderData>.from(
                json["data"].map((x) => OrderData.fromJson(x)))
            : [],
        from: json["from"],
        lastPage: json["last_page"],
        total: json["total"],
        to: json["to"],
        firstPageUrl: json["first_page_url"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": orderData != null
            ? List<dynamic>.from(orderData!.map((x) => x.toJson()))
            : [],
        "from": from,
        "last_page": lastPage,
        "total": total,
        "to": to,
        "first_page_url": firstPageUrl,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "prev_page_url": prevPageUrl,
      };
}
