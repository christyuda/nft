class PinValidateTicketingRequest {
  final String ticketing;

  PinValidateTicketingRequest({required this.ticketing});

  Map<String, dynamic> toJson() {
    return {
      'ticketing': ticketing,
    };
  }
}
