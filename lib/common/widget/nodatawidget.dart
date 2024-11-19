import 'package:flutter/material.dart';

import '../../config/palette.dart';
import '../../config/sizeconf.dart';

class NoDataWidgetWithIlustrator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(flex: 2, child: Container()),
        Expanded(
          flex: 3,
          child: Container(
            height: Sz.wpfactor(context, 45),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/banner/nodata.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(height: Sz.wpfactor(context, 10)),
        Expanded(
            flex: 2,
            child:
                Sz.title(context, 'No Data', TextAlign.left, Palette.blackClr)),
        SizedBox(height: Sz.wpfactor(context, 30)),
      ],
    );
  }
}
