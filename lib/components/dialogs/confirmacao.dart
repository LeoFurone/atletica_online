import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Confirmacao extends StatelessWidget {
  final Function excluirDados;

  const Confirmacao({Key? key, required this.excluirDados}) : super(key: key);


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
            height: 212,
            alignment: Alignment.center,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text(
                    'Excluir dados?',
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Eles não serão recuperados porteriomente.',
                    style: GoogleFonts.quicksand(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 32),
                GestureDetector(
                  onTap: () {
                    excluirDados.call();
                  },
                  child: Container(
                    width: widthScreen * 0.8,
                    height: 60,
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: Text(
                      'Excluir',
                      style: GoogleFonts.quicksand(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: widthScreen * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                    ),
                    height: 60,
                    alignment: Alignment.center,
                    child: Text(
                      'Cancelar',
                      style: GoogleFonts.quicksand(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
