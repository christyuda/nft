class ListMeetingRequest {
  final int page;
  final int size;
  final String? term;
  final String? place;

  ListMeetingRequest({
    required this.page,
    required this.size,
    this.term,
    this.place,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'size': size,
      'term': term,
      'place': place,
    };
  }
}
