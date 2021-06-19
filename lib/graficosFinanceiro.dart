import 'package:flutter/material.dart';

class GraficosFinanceiro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var safeArea = MediaQuery.of(context).padding.top;

    return Container(
      color: Colors.blue,
      height: 100,
      width: 100,
    );
  }
}
