import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:video_player/video_player.dart';
import 'package:webordernft/common/widget/btnwidget.dart';
import 'package:webordernft/config/palette.dart';
import 'package:webordernft/config/sizeconf.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _controller = VideoPlayerController.asset(
      'assets/video/tutorial-nft.mp4',
    )..initialize().then((_) {
        setState(() {
          _controller.setVolume(0.0);
          _controller.setLooping(true);
          _controller.play();

          _isPlaying = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (BuildContext context) => _buildMobileLayout(context),
        tablet: (BuildContext context) => _buildTabletLayout(context),
        desktop: (BuildContext context) => _buildDesktopLayout(context),
      ),
    );
  }

  // Layout untuk mobile screens
  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sz.wpfactor(context, 10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            Container(
              height: MediaQuery.of(context).size.height *
                  0.3, // lebih tinggi untuk mobile
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/banner/cendrawasih.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildContent(context),
            const SizedBox(height: 25),
            Container(
              height: MediaQuery.of(context).size.height *
                  0.2, // Ukuran video lebih kecil
              width: MediaQuery.of(context).size.width * 0.8, // Lebar relatif
              child: _buildVideoPlayer(),
            ),
            const SizedBox(height: 25),
            ActionButton(
              onPressed: () {
                Navigator.pushNamed(context, 'OrderForm');
              },
              labelname: 'Pesan Sekarang / Order Now',
              imgIcon: '',
              icn: Icons.shopping_cart,
              clr: Palette.primary,
              iconClr: Palette.white,
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  // Layout untuk tablet screens
  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sz.wpfactor(context, 15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            Container(
              height: MediaQuery.of(context).size.height *
                  0.3, // Ukuran lebih besar untuk tablet
              width: MediaQuery.of(context).size.width * 0.6,
              child: _buildVideoPlayer(),
            ),
            const SizedBox(height: 30),
            _buildContent(context),
            const SizedBox(height: 30),
            ActionButton(
              onPressed: () {
                Navigator.pushNamed(context, 'OrderForm');
              },
              labelname: 'Pesan Sekarang / Order Now',
              imgIcon: '',
              icn: Icons.shopping_cart,
              clr: Palette.primary,
              iconClr: Palette.white,
            ),
          ],
        ),
      ),
    );
  }

  // Layout untuk desktop screens
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(left: Sz.wpfactor(context, 60)),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/banner/cendrawasih.jpeg'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Sz.wpfactor(context, 64)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildContent(context),
                  const SizedBox(height: 30),
                  Container(
                    height: MediaQuery.of(context).size.height *
                        0.4, // Desktop lebih besar
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: _buildVideoPlayer(),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Sz.wpfactor(context, 240)),
                    child: ActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'OrderForm');
                      },
                      labelname: 'Pesan Sekarang / Order Now',
                      imgIcon: '',
                      icn: Icons.shopping_cart,
                      clr: Palette.primary,
                      iconClr: Palette.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget video player dengan kontrol play/pause
  Widget _buildVideoPlayer() {
    return _controller.value.isInitialized
        ? GestureDetector(
            onTap: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                  _isPlaying = false;
                } else {
                  _controller.play();
                  _isPlaying = true;
                }
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                if (!_isPlaying)
                  const Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: 20, // Ukuran lebih kecil untuk play icon
                  ),
              ],
            ),
          )
        : const CircularProgressIndicator();
  }

  // Konten umum
  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Sz.headline5(
          context,
          'PosIND Rilis Prangko NFT Seri Cenderawasih',
          TextAlign.center,
          Palette.blackClr,
        ),
        const SizedBox(height: 15),
        Sz.bodyText(
          context,
          'Prangko NFT pertama di Indonesia ini diluncurkan dalam bentuk twin stamps berupa booklet, dimana terdapat prangko fisik dan prangko dalam bentuk digital yang tersimpan pada blockchain. Prangko NFT dijual dengan harga Rp. 150.000 (per booklet), ditambah biaya pengiriman sebesar Rp 20.000 berlaku flat ke seluruh Indonesia.',
          TextAlign.center,
          Palette.blackClr,
        ),
        const SizedBox(height: 15),
        Divider(color: Palette.blackClr, thickness: 1),
        Sz.headline5(
          context,
          'PosIND Launches Cenderawasih Series NFT Stamps',
          TextAlign.center,
          Palette.blackClr,
        ),
        const SizedBox(height: 15),
        Sz.bodyText(
          context,
          'The first NFT stamps in Indonesia will be launched in booklet form, in which customers will get 2 versions, physical stamps and NFT stamps.NFT stamps will be sold for Rp. 150,000 (for each booklet), plus shipping costs of flat throughout Indonesia IDR 20,000.',
          TextAlign.center,
          Palette.blackClr,
        ),
        Sz.bodyText(
          context,
          'For foreign customers, please contact us through whatsapp no : +62 818-0602-3341.',
          TextAlign.center,
          Palette.blackClr,
        ),
      ],
    );
  }
}
