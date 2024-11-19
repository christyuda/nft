import 'package:flutter/material.dart';
import 'package:webordernft/config/palette.dart';

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 8,
          decoration: BoxDecoration(
            color: Palette.primary.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 8,
            decoration: BoxDecoration(
              color: Palette.primary,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
