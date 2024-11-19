class OrderResponse {
  final bool status;
  final String message;
  final Map<String, dynamic> data;

  OrderResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? 'No message',
      data: json['data'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data,
    };
  }
}
