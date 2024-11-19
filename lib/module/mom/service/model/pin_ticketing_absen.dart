class PinTicketingAbsenRequest {
  final int meetingId;
  final int audienceId;

  PinTicketingAbsenRequest({
    required this.meetingId,
    required this.audienceId,
  });

  Map<String, dynamic> toJson() {
    return {
      'meetingId': meetingId,
      'audienceId': audienceId,
    };
  }
}
