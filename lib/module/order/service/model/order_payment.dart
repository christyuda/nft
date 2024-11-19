import 'dart:typed_data';

class OrderPaymentProof {
  final int? paymentStatus;
  final int paymentChannel;
  final String cellphone;
  final String? imagePath; // For mobile/desktop
  final List<int>? fileBytes;
  final String? fileName; // Optional: Use for naming files on web

  OrderPaymentProof({
    this.paymentStatus,
    required this.paymentChannel,
    required this.cellphone,
    this.imagePath,
    this.fileBytes,
    this.fileName,
  });
}
