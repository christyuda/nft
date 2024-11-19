import 'dart:convert';

class OrderRequestBody {
  String? startDate;
  String? endDate;
  int? paymentStatus;
  int? paymentChannel;
  int? qty;
  String? ordererName;

  OrderRequestBody({
    this.startDate,
    this.endDate,
    this.paymentStatus,
    this.paymentChannel,
    this.qty,
    this.ordererName,
  });

  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate ?? "",
      'end_date': endDate ?? "",
      'payment_status': paymentStatus ?? null,
      'payment_chanel': paymentChannel ?? null,
      'qty': qty ?? null,
      'orderer_name': ordererName ?? "",
    };
  }

  factory OrderRequestBody.fromJson(Map<String, dynamic> json) {
    return OrderRequestBody(
      startDate: json['start_date'],
      endDate: json['end_date'],
      paymentStatus: json['payment_status'],
      paymentChannel: json['payment_chanel'],
      qty: json['qty'],
      ordererName: json['orderer_name'],
    );
  }

  String toJsonString() {
    return json.encode(toJson());
  }

  factory OrderRequestBody.fromJsonString(String jsonString) {
    return OrderRequestBody.fromJson(json.decode(jsonString));
  }
}
