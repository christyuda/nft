import 'package:flutter/material.dart';

import '../../config/constant.dart';
import '../../config/palette.dart';

class FormStyle {
  labelText() {
    return TextStyle(
      fontFamily: SFProMedium,
      fontSize: 16,
      color: Palette.labelmenu,
    );
  }

  hintText() {
    return TextStyle(
      fontFamily: sfProFnt,
      fontSize: 12,
      color: Palette.labelmenu,
    );
  }
}
