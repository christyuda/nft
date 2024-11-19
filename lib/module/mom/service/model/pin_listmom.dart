class UserAudienceRequest {
  final int page;
  final int size;
  final String term;

  UserAudienceRequest({
    required this.page,
    required this.size,
    required this.term,
  });

  Map<String, dynamic> toJson() {
    return {
      "page": page,
      "size": size,
      "term": term,
    };
  }
}
