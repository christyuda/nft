class ResponseValidateTicketing {
  final bool status;
  final String message;
  final ValidateTicketingData data;

  ResponseValidateTicketing({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ResponseValidateTicketing.fromJson(Map<String, dynamic> json) {
    return ResponseValidateTicketing(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: ValidateTicketingData.fromJson(json['data'] ?? {}),
    );
  }
}

class ValidateTicketingData {
  final int meetingId;
  final int audienceId;
  final String token;

  ValidateTicketingData({
    required this.meetingId,
    required this.audienceId,
    required this.token,
  });

  factory ValidateTicketingData.fromJson(Map<String, dynamic> json) {
    return ValidateTicketingData(
      meetingId: json['meetingId'] ?? 0,
      audienceId: json['audienceId'] ?? 0,
      token: json['token'] ?? '',
    );
  }
}
