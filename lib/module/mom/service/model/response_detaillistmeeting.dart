class GetMeetingByIdResponse {
  final bool status;
  final String message;
  final MeetingData? data;

  GetMeetingByIdResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory GetMeetingByIdResponse.fromJson(Map<String, dynamic> json) {
    return GetMeetingByIdResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? MeetingData.fromJson(json['data']) : null,
    );
  }
}

class MeetingData {
  final int id;
  final String author;
  final String date;
  final String createAt;
  final String time;
  final String place;
  final String agenda;
  final List<AudienceDetail> audiences;
  final List<Catatan> notes;
  final String material;

  MeetingData({
    required this.id,
    required this.author,
    required this.date,
    required this.createAt,
    required this.time,
    required this.place,
    required this.agenda,
    required this.audiences,
    required this.notes,
    required this.material,
  });

  factory MeetingData.fromJson(Map<String, dynamic> json) {
    return MeetingData(
      id: json['id'] ?? 0,
      author: json['author'] ?? '',
      date: json['date'] ?? '',
      createAt: json['create_at'] ?? '',
      time: json['time'] ?? '',
      place: json['place'] ?? '',
      agenda: json['agenda'] ?? '',
      audiences: (json['audiences'] as List<dynamic>?)
              ?.map((e) => AudienceDetail.fromJson(e))
              .toList() ??
          [],
      notes: (json['notes'] as List<dynamic>?)
              ?.map((e) => Catatan.fromJson(e))
              .toList() ??
          [],
      material: json['material'] ?? '',
    );
  }
}

class AudienceDetail {
  final int id;
  final String name;
  final String nik;
  final String position;
  final String stakeholder;
  final String? signing;
  final int status;
  final int isPresent;
  final int representativeSigner;
  final String? representativeSigning;

  AudienceDetail({
    required this.id,
    required this.name,
    required this.nik,
    required this.position,
    required this.stakeholder,
    this.signing,
    required this.status,
    required this.isPresent,
    required this.representativeSigner,
    this.representativeSigning,
  });

  factory AudienceDetail.fromJson(Map<String, dynamic> json) {
    return AudienceDetail(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nik: json['nik'] ?? '',
      position: json['position'] ?? '',
      stakeholder: json['stakeholder'] ?? '',
      signing: json['signing'],
      status: json['status'] ?? 0,
      isPresent: json['is_present'] ?? 0,
      representativeSigner: json['representative_signer'] ?? 0,
      representativeSigning: json['representative_signing'],
    );
  }
}

class Catatan {
  final int id;
  final String notes;
  final String pic;
  final String dueDate;
  final String createdAt;

  Catatan({
    required this.id,
    required this.notes,
    required this.pic,
    required this.dueDate,
    required this.createdAt,
  });

  factory Catatan.fromJson(Map<String, dynamic> json) {
    return Catatan(
      id: json['id'] ?? 0,
      notes: json['notes'] ?? '',
      pic: json['pic'] ?? '',
      dueDate: json['due_date'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}
