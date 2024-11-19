import 'dart:convert';

OrderList orderListFromJson(String str) => OrderList.fromJson(json.decode(str));

String orderListToJson(OrderList data) => json.encode(data.toJson());

class OrderList {
  OrderList({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
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
  List<OrderData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<OrderData>.from(
                json["data"]!.map((x) => OrderData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
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

class OrderData {
  OrderData({
    this.id,
    this.ordererName,
    this.cellphone,
    this.email,
    this.address,
    this.city,
    this.postcode,
    this.qty,
    this.price,
    this.shippingCost,
    this.orderAmount,
    this.paymentChanel,
    this.paymentStatus,
    this.orderStatus,
    this.proofOfPayment,
    this.shippingReceiptNumber,
    this.trxDate,
    this.paymentMethod,
    this.paymentStatusText,
    this.orderStatusText,
    this.noResi,
  });

  int? id;
  String? ordererName;
  String? cellphone;
  String? email;
  String? address;
  String? city;
  int? postcode;
  int? qty;
  int? price;
  int? shippingCost;
  int? orderAmount;
  int? paymentChanel;
  int? paymentStatus;
  int? orderStatus;
  String? proofOfPayment;
  String? shippingReceiptNumber;
  String? trxDate;
  String? paymentMethod;
  String? paymentStatusText;
  String? orderStatusText;
  String? noResi;

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        id: json["id"],
        ordererName: json["orderer_name"],
        cellphone: json["cellphone"],
        email: json["email"],
        address: json["address"],
        city: json["city"],
        postcode: json["postcode"],
        qty: json["qty"],
        price: json["price"],
        shippingCost: json["shipping_cost"],
        orderAmount: json["order_amount"],
        paymentChanel: json["payment_chanel"],
        paymentStatus: json["payment_status"],
        orderStatus: json["order_status"],
        proofOfPayment: json["proof_of_payment"],
        shippingReceiptNumber: json["shipping_receipt_number"],
        trxDate: json["trx_date"],
        paymentMethod: json["payment_method"],
        paymentStatusText: json["payment_status_text"],
        orderStatusText: json["order_status_text"],
        noResi: json["no_resi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderer_name": ordererName,
        "cellphone": cellphone,
        "email": email,
        "address": address,
        "city": city,
        "postcode": postcode,
        "qty": qty,
        "price": price,
        "shipping_cost": shippingCost,
        "order_amount": orderAmount,
        "payment_chanel": paymentChanel,
        "payment_status": paymentStatus,
        "order_status": orderStatus,
        "proof_of_payment": proofOfPayment,
        "shipping_receipt_number": shippingReceiptNumber,
        "trx_date": trxDate,
        "payment_method": paymentMethod,
        "payment_status_text": paymentStatusText,
        "order_status_text": orderStatusText,
        "no_resi": noResi,
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
