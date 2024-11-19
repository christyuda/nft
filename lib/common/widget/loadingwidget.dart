import 'package:flutter/material.dart';

class Loadingwidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: const CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent)),
      ),
    );
  }
}
