import 'package:flutter/material.dart';

import '../../config/palette.dart';
import '../../config/sizeconf.dart';
// import 'package:line_icons/line_icons.dart';

class ReuseAppBar {
  static getAppBar(context, String title, String subtitle) {
    return AppBar(
      centerTitle: false,

      backgroundColor: Palette.primary,
      automaticallyImplyLeading: false,
      // automaticallyImplyLeading: false,
      iconTheme:
          IconThemeData(color: Palette.white, size: 24 //change your color here
              ),
      title: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Sz.headline6(context, title, TextAlign.left, Palette.white),
                Sz.subtitle(context, subtitle, TextAlign.left, Palette.white)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
