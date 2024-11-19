class ListAudiencesRequest {
  final int meetingId;

  ListAudiencesRequest({required this.meetingId});

  Map<String, dynamic> toJson() {
    return {
      'meetingId': meetingId,
    };
  }
}
