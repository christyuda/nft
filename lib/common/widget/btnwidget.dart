import 'package:flutter/material.dart';
import 'package:webordernft/common/widget/spacer.dart';

import '../../config/constant.dart';
import '../../config/palette.dart';
import '../../config/sizeconf.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String labelname;
  final IconData icn;
  final Color clr;

  SubmitButton(
      {required this.onPressed,
      required this.labelname,
      required this.icn,
      required this.clr});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Palette.primary),
        minimumSize: MaterialStateProperty.all(
          Size(100, 48),
        ), // Sesuaikan ukuran di sini
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10.0), // Sesuaikan sudut melengkung di sini
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Sz.buttonText(context, labelname, TextAlign.left, Palette.white),
          SpaceHorizontal(size: 5),
          Icon(icn, size: 15, color: clr),
        ],
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String labelname;

  CancelButton({
    required this.onPressed,
    required this.labelname,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            minimumSize: MaterialStateProperty.all(
              Size(100, 49),
            ), // Sesuaikan ukuran di sini
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    radiusVal), // Sesuaikan sudut melengkung di sini
              ),
            ),
            padding: WidgetStatePropertyAll(EdgeInsets.all(1))),
        onPressed: onPressed,
        child: Row(
          children: [
            Expanded(
              child: Sz.buttonText(
                  context, labelname, TextAlign.center, Palette.primary),
            )
          ],
        ));
  }
}

class CtaButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String labelname;
  final IconData icn;
  final Color clr;

  CtaButton({
    required this.onPressed,
    required this.labelname,
    required this.icn,
    required this.clr,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(clr),
        minimumSize: MaterialStateProperty.all(
          Size(100, 45),
        ), // Sesuaikan ukuran di sini
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10.0), // Sesuaikan sudut melengkung di sini
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Sz.buttonText(
                context, labelname, TextAlign.left, Palette.white),
          ),
          SpaceHorizontal(size: 5),
          Icon(
            icn,
            size: 25,
            color: Palette.white,
          ),
        ],
      ),
    );
  }
}

//
class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String labelname;
  final String imgIcon;
  final IconData icn;
  final Color clr;
  final Color iconClr;

  ActionButton({
    required this.onPressed,
    required this.labelname,
    required this.imgIcon,
    required this.icn,
    required this.clr,
    required this.iconClr,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(clr),
          minimumSize: MaterialStateProperty.all(
            Size(100, 49),
          ), // Sesuaikan ukuran di sini
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  radiusVal), // Sesuaikan sudut melengkung di sini
            ),
          ),
          padding: WidgetStatePropertyAll(EdgeInsets.all(1))),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Sz.subtitle(context, labelname, TextAlign.left, Palette.white),
          SpaceHorizontal(size: 5),
          Icon(
            icn,
            size: 20,
            color: Palette.white,
          )
        ],
      ),
    );
  }
}
