class SignAudienceResponse {
  final bool status;
  final String message;
  final String? imageUrl; // For image URL if the status is 1 or 2
  final String? qrImageUrl; // For QR image URL if the status is 2

  SignAudienceResponse({
    required this.status,
    required this.message,
    this.imageUrl,
    this.qrImageUrl,
  });

  factory SignAudienceResponse.fromJson(Map<String, dynamic> json) {
    return SignAudienceResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      imageUrl: json['data']?['image_url'],
      qrImageUrl: json['data']?['qr_image_url'],
    );
  }
}
