import 'dart:typed_data';

class SignAudienceRequest {
  final int meetingId;
  final int audienceId;
  final int status;
  final int isPresent;
  final Uint8List? signatureData; // Optional signature data

  SignAudienceRequest({
    required this.meetingId,
    required this.audienceId,
    required this.status,
    required this.isPresent,
    this.signatureData,
  });

  // Convert necessary fields to a map for form-data requests
  Map<String, String> toFields() {
    return {
      'id_mom': meetingId.toString(),
      'id_audiences': audienceId.toString(),
      'status': status.toString(),
      'is_present': isPresent.toString(),
    };
  }

  // Convert signature data to map if needed for form-data requests
  Map<String, Uint8List?> toFiles() {
    return {
      'signature': signatureData,
    };
  }
}
