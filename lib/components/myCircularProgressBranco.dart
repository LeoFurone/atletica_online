import 'package:flutter/material.dart';

class MyCircularProgressBranco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
          Colors.white),
      backgroundColor: Colors.white,
    );
  }
}
