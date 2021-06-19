import 'package:flutter/material.dart';

class Vazio extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
