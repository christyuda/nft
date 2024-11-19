import 'package:flutter/material.dart';

import '../../config/constant.dart';

class Sz {
  // -------  New Format      ----------
  /// NAME         SIZE  WEIGHT  SPACING
  /// headline1    96.0  light   -1.5
  /// headline2    60.0  light   -0.5
  /// headline3    48.0  regular  0.0
  /// headline4    34.0  regular  0.25
  /// headline5    24.0  regular  0.0
  /// headline6    20.0  medium   0.15
  /// subtitle1    16.0  regular  0.15
  /// subtitle2    14.0  medium   0.1
  /// body1        16.0  regular  0.5   (bodyText1)
  /// body2        14.0  regular  0.25  (bodyText2)
  /// button       14.0  medium   1.25
  /// caption      12.0  regular  0.4
  /// overline     10.0  regular  1.5

  static headline4(context, judul, TextAlign align, clr) {
    return Text(
      '$judul',
      textAlign: align,
      style: TextStyle(
        fontSize: 34,
        fontFamily: sfProFnt,
        letterSpacing: 0.25,
        fontWeight: FontWeight.bold,
        color: clr,
      ),
      // textScaleFactor: textScaleFactorsz(context),
    );
  }

  static headline5(context, judul, TextAlign align, clr) {
    return Text(
      '$judul',
      textAlign: align,
      style: TextStyle(
        fontSize: 24,
        fontFamily: SFProSemiBoldFnt,
        letterSpacing: 0.0,
        fontWeight: FontWeight.bold,
        color: clr,
      ),
      // textScaleFactor: textScaleFactorsz(context),
    );
  }

  static headline6(context, judul, TextAlign align, clr) {
    return Text(
      '$judul',
      textAlign: align,
      style: TextStyle(
        fontSize: 20,
        fontFamily: SFProMedium,
        letterSpacing: 0.15,
        fontWeight: FontWeight.bold,
        color: clr,
      ),
      // textScaleFactor: textScaleFactorsz(context),
    );
  }

  static headline(context, judul, TextAlign align, clr) {
    return Text(
      '$judul',
      textAlign: align,
      style: TextStyle(
        fontSize: 18,
        fontFamily: SFProMedium,
        letterSpacing: 0.15,
        color: clr,
      ),
      // textScaleFactor: textScaleFactorsz(context),
    );
  }

  static title(context, judul, TextAlign align, clr) {
    return Text(
      '$judul',
      textAlign: align,
      style: TextStyle(
        fontSize: 16,
        fontFamily: sfProFnt,
        letterSpacing: 0.15,
        fontWeight: FontWeight.bold,
        color: clr,
      ),
      // style: Theme.of(context).textTheme.subtitle1,
      // textScaleFactor: textScaleFactorsz(context),
    );
  }

  static titleNebula(context, judul, TextAlign align, clr) {
    return Text(
      '$judul',
      textAlign: align,
      style: TextStyle(
        fontSize: 8,
        fontFamily: NebulaReg,
        letterSpacing: 0.15,
        fontWeight: FontWeight.bold,
        color: clr,
      ),
      // style: Theme.of(context).textTheme.subtitle1,
      // textScaleFactor: textScaleFactorsz(context),
    );
  }

  static subtitle(context, judul, TextAlign align, clr) {
    return Text(
      '$judul',
      textAlign: align,
      style: TextStyle(
        fontSize: 14,
        fontFamily: sfProFnt,
        letterSpacing: 0.1,
        color: clr,
      ),
      // textScaleFactor: textScaleFactorsz(context),
    );
  }

  static bodyText(context, judul, TextAlign align, clr) {
    return Text(
      '$judul',
      textAlign: align,
      style: TextStyle(
        fontSize: 12,
        fontFamily: sfProFnt,
        letterSpacing: 0.5,
        color: clr,
      ),
      // textScaleFactor: textScaleFactorsz(context),
    );
  }

  static caption(context, judul, TextAlign align, clr) {
    return Text(
      '$judul',
      textAlign: align,
      style: TextStyle(
        fontSize: 11,
        fontFamily: sfProFnt,
        letterSpacing: 0.4,
        color: clr,
      ),
      // textScaleFactor: textScaleFactorsz(context),
    );
  }

  static overline(context, judul, TextAlign align, clr) {
    return Text(
      '$judul',
      textAlign: align,
      style: TextStyle(
        fontSize: 10,
        fontFamily: sfProFnt,
        letterSpacing: 1.5,
        color: clr,
      ),
      // textScaleFactor: textScaleFactorsz(context),
    );
  }

  static buttonText(context, judul, TextAlign align, clr) {
    return Text(
      '$judul',
      textAlign: align,
      style: TextStyle(
        fontSize: 18,
        fontFamily: SFProMedium,
        letterSpacing: 1.25,
        color: clr,
        // fontWeight: FontWeight.bold,
        // height:
      ),
      // textScaleFactor: textScaleFactorsz(context),
    );
  }

  // -------  END New Format  ----------

  // final scale = mockupWidth / width;
  // final textScaleFactor = width / mockupWidth;
  // 50 / mockupHeight * height

  static wpfactor(context, factor) {
    double wpfc = factor / widthsz(context) * mockupWidth;
    return wpfc;
  }

  static hpfactor(context, factor) {
    double wpfc = factor / heightsz(context) * mockupHeight;
    return wpfc;
  }

  static widthsz(context) {
    final width = MediaQuery.of(context).size.width;
    return width;
  }

  static heightsz(context) {
    final height = MediaQuery.of(context).size.height;
    return height;
  }

  static scalesz(context) {
    final scale = mockupWidth / widthsz(context);
    return scale;
  }

  static textScaleFactorsz(context) {
    double txtScale = widthsz(context) / mockupWidth;
    return txtScale;
  }
}
