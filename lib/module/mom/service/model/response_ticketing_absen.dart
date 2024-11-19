class PinTicketingAbsenResponse {
  final bool status;
  final String message;
  final TicketingData data;

  PinTicketingAbsenResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PinTicketingAbsenResponse.fromJson(Map<String, dynamic> json) {
    return PinTicketingAbsenResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: TicketingData.fromJson(json['data'] ?? {}),
    );
  }
}

class TicketingData {
  final String ticketing;

  TicketingData({
    required this.ticketing,
  });

  factory TicketingData.fromJson(Map<String, dynamic> json) {
    return TicketingData(
      ticketing: json['ticketing'] ?? '',
    );
  }
}
