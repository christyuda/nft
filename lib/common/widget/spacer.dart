import 'package:flutter/material.dart';

import '../../config/sizeconf.dart';

class SpaceVertical extends StatelessWidget {
  final size;

  const SpaceVertical({
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: Sz.hpfactor(context, size));
  }
}

class SpaceHorizontal extends StatelessWidget {
  final size;

  const SpaceHorizontal({
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: Sz.hpfactor(context, size));
  }
}
