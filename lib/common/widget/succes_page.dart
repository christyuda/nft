import 'package:flutter/material.dart';
import 'package:webordernft/common/widget/animation_icon.dart';
import 'package:webordernft/config/palette.dart';
import 'package:webordernft/config/sizeconf.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = Sz.widthsz(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Palette.primary,
        automaticallyImplyLeading: false,
        title: Sz.headline5(
          context,
          'Berhasil',
          TextAlign.center,
          Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sz.wpfactor(context, 16)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ikon centang animasi
              const AnimatedCheckIcon(),
              SizedBox(height: Sz.hpfactor(context, 30)),
              Sz.headline5(
                context,
                'Pemesanan Berhasil!',
                TextAlign.center,
                Colors.black87,
              ),
              SizedBox(height: Sz.hpfactor(context, 20)),
              Sz.subtitle(
                context,
                'Terima kasih atas pesanan Anda. Kami akan memverifikasi pembayaran dan segera memproses pesanan Anda.',
                TextAlign.center,
                Colors.grey,
              ),
              SizedBox(height: Sz.hpfactor(context, 40)),
              // Tombol untuk kembali ke dashboard atau halaman utama
              SizedBox(
                width: screenWidth * 0.4, // Menyesuaikan lebar secara responsif
                height: Sz.hpfactor(context, 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Arahkan ke halaman utama atau dashboard
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  },
                  child: Sz.buttonText(
                    context,
                    'Kembali',
                    TextAlign.center,
                    Colors.white,
                  ),
                ),
              ),
              SizedBox(height: Sz.hpfactor(context, 20)),
              // Tombol untuk melihat detail pesanan (Jika diperlukan)
              // TextButton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, 'OrderDetails');
              //   },
              //   child: Sz.subtitle(
              //     context,
              //     'Lihat Detail Pesanan',
              //     TextAlign.center,
              //     Colors.blueAccent,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
