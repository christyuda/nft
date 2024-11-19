import 'package:flutter/material.dart';
import 'package:webordernft/config/palette.dart';
import 'package:webordernft/config/sizeconf.dart';

class FormAddMenu extends StatefulWidget {
  const FormAddMenu({Key? key}) : super(key: key);

  @override
  State<FormAddMenu> createState() => _FormAddMenuState();
}

class _FormAddMenuState extends State<FormAddMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Sz.headline6(context, 'Add menu', TextAlign.center, Palette.primary),
    );
  }
}
