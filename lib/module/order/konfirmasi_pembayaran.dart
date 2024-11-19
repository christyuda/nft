import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates
import 'package:provider/provider.dart';
import 'package:webordernft/common/widget/spacer.dart';
import 'package:webordernft/config/palette.dart';
import 'package:webordernft/module/order/provider/order_provider.dart';
import 'package:webordernft/module/order/service/model/order_request.dart';
import 'package:webordernft/module/order/service/model/order_response.dart';
import 'package:webordernft/module/order/service/order_service.dart';

import '../../common/utils/appbar.dart';

class KonfirmasiPembayaran extends StatefulWidget {
  const KonfirmasiPembayaran({super.key});

  @override
  State<KonfirmasiPembayaran> createState() => _KonfirmasiPembayaranState();
}

class _KonfirmasiPembayaranState extends State<KonfirmasiPembayaran> {
  @override
  void initState() {
    super.initState();
    // Generate CAPTCHA saat layar dimuat
    Provider.of<OrderProvider>(context, listen: false).generateCaptcha();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenPadding = screenWidth > 1200 ? 100.0 : 20.0;

    return Scaffold(
      appBar:
          ReuseAppBar.getAppBar(context, 'Ringkasan Pesanan', 'Order Summary'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SpaceVertical(size: 16),
              Text(
                'Ringkasan Pesanan NFT Cendrawasih',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SpaceVertical(size: 16),
              _buildOrderCard(context, orderProvider),
              SpaceVertical(size: 16),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderProvider orderProvider) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Palette.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderSummaryTile(
                context, 'Tanggal', DateFormat.yMMMMd().format(DateTime.now())),
            _buildOrderSummaryTile(context, 'Nama Pemesan',
                orderProvider.orderName ?? 'Not specified'),
            _buildOrderSummaryTile(context, 'Nomor HP',
                orderProvider.phoneNumber ?? 'Not specified'),
            _buildOrderSummaryTile(
                context, 'Email', orderProvider.email ?? 'Not specified'),
            _buildOrderSummaryTile(context, 'Alamat Pengiriman',
                orderProvider.address ?? 'Not specified'),
            _buildOrderSummaryTile(
                context, 'Kota', orderProvider.city ?? 'Not specified'),
            _buildOrderSummaryTile(
                context, 'Kode Pos', orderProvider.postCode ?? 'Not specified'),
            _buildOrderSummaryTile(context, 'Jumlah Pesanan',
                orderProvider.orderAmount.toString()),
            _buildOrderSummaryTile(
                context, 'Harga', _formatCurrency(orderProvider.price)),
            _buildOrderSummaryTile(
                context, 'Total', _formatCurrency(orderProvider.total)),
            _buildOrderSummaryTile(context, 'Biaya Pengiriman',
                _formatCurrency(orderProvider.shippingCost)),
            Divider(thickness: 1.5, color: Palette.primary),
            _buildOrderSummaryTile(context, 'Total yang harus dibayar',
                _formatCurrency(orderProvider.totalToBePaid),
                isBold: true),
            SpaceVertical(size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummaryTile(
      BuildContext context, String title, String value,
      {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
          label: Text('Kembali', style: TextStyle(color: Colors.black)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadowColor: Colors.black,
            elevation: 5,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            _showCaptchaDialog(context);
          },
          icon: Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          label: Text(
            'Checkout',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.primary,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadowColor: Palette.primary,
            elevation: 5,
          ),
        ),
      ],
    );
  }

  void _showCaptchaDialog(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Verifikasi CAPTCHA'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Row untuk menampilkan CAPTCHA dan tombol refresh di sebelahnya
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Kotak CAPTCHA
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.lightBlueAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.4),
                              blurRadius: 8,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          orderProvider.generatedCaptcha,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // Ikon refresh
                      IconButton(
                        icon: Icon(Icons.refresh, color: Colors.blue),
                        onPressed: () {
                          setState(() {
                            orderProvider.generateCaptcha(); // Refresh CAPTCHA
                          });
                        },
                      ),
                    ],
                  ),
                  SpaceVertical(size: 16),
                  TextField(
                    onChanged: (value) {
                      orderProvider.enteredCaptcha = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Masukkan kode CAPTCHA',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Batal'),
                  onPressed: () {
                    orderProvider.generateCaptcha();
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: Colors.white,
                    shadowColor: Colors.black,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                ElevatedButton(
                  child: Text(
                    'Verifikasi',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (orderProvider.validateCaptcha()) {
                      OrderModel orderRequest = OrderModel(
                        ordererName: orderProvider.orderName ?? '',
                        cellphone: orderProvider.phoneNumber ?? '',
                        email: orderProvider.email ?? '',
                        address: orderProvider.address ?? '',
                        city: orderProvider.city ?? '',
                        postcode: orderProvider.postCode ?? '',
                        qty: orderProvider.orderAmount,
                        price: orderProvider.price,
                        shippingCost: orderProvider.shippingCost,
                        orderAmount: orderProvider.totalToBePaid,
                      );

                      try {
                        OrderResponse response = await OrderService.submitOrder(
                          context,
                          orderRequest.toJson(),
                        );

                        if (response.status) {
                          Navigator.pushNamed(context, 'ConfirmPayment');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Order submission failed: ${response.message}')),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Kode CAPTCHA salah. Coba lagi.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Palette.primary,
                    shadowColor: Colors.black,
                    elevation: 4,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _formatCurrency(double amount) {
    final format =
        NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
    return format.format(amount);
  }
}
