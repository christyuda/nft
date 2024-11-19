// To parse this JSON data, do
//
//     final ticketIssueMontly = ticketIssueMontlyFromJson(jsonString);

import 'dart:convert';

List<TicketIssueMonthly> ticketIssueMontlyFromJson(String str) =>
    List<TicketIssueMonthly>.from(
        json.decode(str).map((x) => TicketIssueMonthly.fromJson(x)));

String ticketIssueMontlyToJson(List<TicketIssueMonthly> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TicketIssueMonthly {
  TicketIssueMonthly({
    this.issue,
    this.jumlah,
  });

  String? issue;
  String? jumlah;

  factory TicketIssueMonthly.fromJson(Map<String, dynamic> json) =>
      TicketIssueMonthly(
        issue: json["issue"],
        jumlah: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "issue": issue,
        "jumlah": jumlah,
      };
}
