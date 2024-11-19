import 'dart:typed_data';

class ListMeetingResponse {
  final bool status;
  final String message;
  final Data data;

  ListMeetingResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ListMeetingResponse.fromJson(Map<String, dynamic> json) {
    return ListMeetingResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: Data.fromJson(json['data'] ?? {}),
    );
  }
}

class Data {
  final Pagination pagination;
  final List<Meeting> meetings;

  Data({
    required this.pagination,
    required this.meetings,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
      meetings: (json['meetings'] as List? ?? [])
          .map((meeting) => Meeting.fromJson(meeting))
          .toList(),
    );
  }
}

class Pagination {
  final int totalRecords;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final int? nextPage;
  final int? previousPage;
  final PaginationIcons icons;

  Pagination({
    required this.totalRecords,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    this.nextPage,
    this.previousPage,
    required this.icons,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalRecords: json['total_records'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
      currentPage: json['current_page'] ?? 0,
      pageSize: json['page_size'] ?? 0,
      nextPage: json['next_page'],
      previousPage: json['previous_page'],
      icons: PaginationIcons.fromJson(json['icons'] ?? {}),
    );
  }
}

class PaginationIcons {
  final String next;
  final String previous;

  PaginationIcons({
    required this.next,
    required this.previous,
  });

  factory PaginationIcons.fromJson(Map<String, dynamic> json) {
    return PaginationIcons(
      next: json['next'] ?? '',
      previous: json['previous'] ?? '',
    );
  }
}

class Meeting {
  final int id;
  final String author;
  final String date;
  final String createAt;
  final String time;
  final String place;
  final String agenda;
  final List<Audience> audiences;
  final List<Note> notes;
  final String material;

  Meeting({
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

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json['id'] ?? 0,
      author: json['author'] ?? '',
      date: json['date'] ?? '',
      createAt: json['create_at'] ?? '',
      time: json['time'] ?? '',
      place: json['place'] ?? '',
      agenda: json['agenda'] ?? '',
      audiences: (json['audiences'] as List? ?? [])
          .map((audience) => Audience.fromJson(audience))
          .toList(),
      notes: (json['notes'] as List? ?? [])
          .map((note) => Note.fromJson(note))
          .toList(),
      material: json['material'] ?? '',
    );
  }
}

class Audience {
  final int id;
  final String? name;
  final String? nik;
  final String? position;
  final String? stakeholder;
  final String? signing;
  int? status;
  final int? isPresent;
  final int? representativeSigner;
  final String? representativeSign;

  Audience({
    required this.id,
    this.name,
    this.nik,
    this.position,
    this.stakeholder,
    this.signing,
    this.status,
    this.isPresent,
    this.representativeSigner,
    this.representativeSign,
  });

  factory Audience.fromJson(Map<String, dynamic> json) {
    return Audience(
      id: json['id'] ?? 0,
      name: json['name'],
      nik: json['nik'],
      position: json['position'],
      stakeholder: json['stakeholder'],
      signing: json['signing'],
      status: json['status'],
      isPresent: json['is_present'],
      representativeSigner: json['representative_signer'],
      representativeSign: json['representative_signing'],
    );
  }
}

class Note {
  final int id;
  final String notes;
  final String? pic;
  final String? dueDate;
  final String createdAt;

  Note({
    required this.id,
    required this.notes,
    this.pic,
    this.dueDate,
    required this.createdAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] ?? 0,
      notes: json['notes'] ?? '',
      pic: json['pic'],
      dueDate: json['due_date'],
      createdAt: json['created_at'] ?? '',
    );
  }
}

class Material {
  final int id;
  final String material;

  Material({
    required this.id,
    required this.material,
  });

  factory Material.fromJson(Map<String, dynamic> json) {
    return Material(
      id: json['id'] ?? 0,
      material: json['material'] ?? '',
    );
  }
}
