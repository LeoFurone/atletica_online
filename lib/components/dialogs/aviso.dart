import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Aviso extends StatelessWidget {
  final String titulo;
  final String subTitulo;
  final Color? color;

  const Aviso({Key? key, required this.titulo, required this.subTitulo, required this.color}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            width: widthScreen * 0.8,
//            height: 165,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text(
                    titulo,
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    subTitulo,
                    style: GoogleFonts.quicksand(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 32),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: widthScreen * 0.8,
                    height: 60,
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: Text(
                      'Ok',
                      style: GoogleFonts.quicksand(
                          color: color,
                          fontSize: 16,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
