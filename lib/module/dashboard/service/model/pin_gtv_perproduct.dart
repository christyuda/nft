// To parse this JSON data, do
//
//     final pinGtvPerProduct = pinGtvPerProductFromJson(jsonString);

import 'dart:convert';

PinGtvPerProduct pinGtvPerProductFromJson(String str) =>
    PinGtvPerProduct.fromJson(json.decode(str));

String pinGtvPerProductToJson(PinGtvPerProduct data) =>
    json.encode(data.toJson());

class PinGtvPerProduct {
  PinGtvPerProduct({
    this.month,
    this.year,
  });

  String? month;
  String? year;

  factory PinGtvPerProduct.fromJson(Map<String, dynamic> json) =>
      PinGtvPerProduct(
        month: json["month"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "year": year,
      };
}
