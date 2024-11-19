import 'package:flutter/material.dart';
import 'package:webordernft/config/palette.dart';
import 'package:webordernft/config/sizeconf.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/banner/welcome.png'),
            // height: Sz.hpfactor(context, 700),
            width: Sz.wpfactor(context, 700),
          ),
          SizedBox(
            height: Sz.hpfactor(context, 20),
          ),
          Sz.headline(context, 'Welcome', TextAlign.center, Palette.primary)
        ],
      ),
    );
  }
}
