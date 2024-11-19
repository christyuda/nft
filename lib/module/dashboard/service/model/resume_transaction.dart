// To parse this JSON data, do
//
//     final resumeTransaction = resumeTransactionFromJson(jsonString);

import 'dart:convert';

List<ResumeTransaction> resumeTransactionFromJson(String str) =>
    List<ResumeTransaction>.from(
        json.decode(str).map((x) => ResumeTransaction.fromJson(x)));

String resumeTransactionToJson(List<ResumeTransaction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResumeTransaction {
  ResumeTransaction({
    this.totalTransaction,
    this.totalBillAmount,
    this.totalFeeAmount,
    this.identifieR,
  });

  int? totalTransaction;
  String? totalBillAmount;
  String? totalFeeAmount;
  String? identifieR;

  factory ResumeTransaction.fromJson(Map<String, dynamic> json) =>
      ResumeTransaction(
        totalTransaction: json["total_transaction"],
        totalBillAmount: json["total_bill_amount"],
        totalFeeAmount: json["total_fee_amount"],
        identifieR: json["identifieR"],
      );

  Map<String, dynamic> toJson() => {
        "total_transaction": totalTransaction,
        "total_bill_amount": totalBillAmount,
        "total_fee_amount": totalFeeAmount,
        "identifieR": identifieR,
      };
}
