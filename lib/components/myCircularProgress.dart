import 'package:atletica_online/components/colors.dart';
import 'package:flutter/material.dart';

class MyCircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
          Colors.white),
      backgroundColor: cor_do_app,
    );
  }
}
