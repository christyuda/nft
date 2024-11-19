class UserAudienceData {
  final bool status;
  final String message;
  final int totalRecords;
  final int currentPage;
  final int pageSize;
  final List<User> audiences;

  UserAudienceData({
    required this.status,
    required this.message,
    required this.totalRecords,
    required this.currentPage,
    required this.pageSize,
    required this.audiences,
  });

  factory UserAudienceData.fromJson(Map<String, dynamic> json) {
    return UserAudienceData(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      totalRecords: json['data']?['total_records'] ?? 0,
      currentPage: json['data']?['current_page'] ?? 0,
      pageSize: json['data']?['page_size'] ?? 0,
      audiences: (json['data']?['audiences'] as List<dynamic>?)
              ?.map((item) => User.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class User {
  final int id;
  final int idMom;
  final String? name;
  final String? nik;
  final String? position;
  final String? stakeholder;
  final String? signing;
  final int status;

  User({
    required this.id,
    required this.idMom,
    this.name,
    this.nik,
    this.position,
    this.stakeholder,
    this.signing,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      idMom: json['id_mom'] ?? 0,
      name: json['name'],
      nik: json['nik'],
      position: json['position'],
      stakeholder: json['stakeholder'],
      signing: json['signing'],
      status: json['status'] ?? 0,
    );
  }
}
