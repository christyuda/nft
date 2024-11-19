class MeetingResponse {
  final bool status;
  final String message;
  final int id;

  MeetingResponse({
    required this.status,
    required this.message,
    required this.id,
  });

  factory MeetingResponse.fromJson(Map<String, dynamic> json) {
    return MeetingResponse(
      status: json['status'],
      message: json['message'],
      id: json['data']['id'],
    );
  }
}
