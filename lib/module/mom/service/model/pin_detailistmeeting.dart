class GetMeetingByIdRequest {
  final int meetingId;

  GetMeetingByIdRequest({required this.meetingId});

  Map<String, dynamic> toJson() {
    return {
      'meetingId': meetingId,
    };
  }
}
