class OrderModel {
  final String ordererName;
  final String cellphone;
  final String email;
  final String address;
  final String city;
  final String postcode;
  final int qty;
  final double price;
  final double shippingCost;
  final double orderAmount;

  OrderModel({
    required this.ordererName,
    required this.cellphone,
    required this.email,
    required this.address,
    required this.city,
    required this.postcode,
    required this.qty,
    required this.price,
    required this.shippingCost,
    required this.orderAmount,
  });

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      "orderer_name": ordererName,
      "cellphone": cellphone,
      "email": email,
      "address": address,
      "city": city,
      "postcode": postcode,
      "qty": qty,
      "price": price,
      "shipping_cost": shippingCost,
      "order_amount": orderAmount,
    };
  }
}
