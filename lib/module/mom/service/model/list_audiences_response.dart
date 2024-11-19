import 'package:flutter/foundation.dart';

class ListAudiencesResponse {
  final bool status;
  final String message;
  final List<Audience> data;

  ListAudiencesResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ListAudiencesResponse.fromJson(Map<String, dynamic> json) {
    return ListAudiencesResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List)
          .map((audience) => Audience.fromJson(audience))
          .toList(),
    );
  }
}

class Audience {
  final int audienceId;
  final String name;
  final String nik;
  final String position;
  final String stakeholder;
  final String? signing;
  int status;
  final int isPresent;
  final int? representativeSigner;
  final String? representativeSigning;

  Audience({
    required this.audienceId,
    required this.name,
    required this.nik,
    required this.position,
    required this.stakeholder,
    this.signing,
    required this.status,
    required this.isPresent,
    this.representativeSigner,
    this.representativeSigning,
  });

  factory Audience.fromJson(Map<String, dynamic> json) {
    return Audience(
      audienceId: json['audience_id'],
      name: json['name'],
      nik: json['nik'],
      position: json['position'],
      stakeholder: json['stakeholder'],
      signing: json['signing'],
      status: json['status'],
      isPresent: json['is_present'],
      representativeSigner: json['representative_signer'],
      representativeSigning: json['representative_signing'],
    );
  }
}
