import 'package:atletica_online/components/tituloSessao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atletica_online/globals.dart' as globals;

import '../colors.dart';

class AdicionaSubTask extends StatelessWidget {
  final TextEditingController descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              width: widthScreen * 0.8,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 16),
                    TituloSessao(titulo: 'Adicionar Sub Task'),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: myTextField(descricaoController)),
                    GestureDetector(
                      onTap: () {
                        Get.back(result: descricaoController.text);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: widthScreen - 16,
                          decoration: BoxDecoration(color: cor_do_app),
                          child: Center(
                            child: Text(
                              'SALVAR',
                              style: GoogleFonts.quicksand(
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Padding myTextField(TextEditingController tController,
      {TextInputType type = TextInputType.text, int lines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 16),
      child: Container(
        color: Colors.grey[200],
        height: 50,
        alignment: lines == null ? Alignment.topLeft : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextField(
            controller: tController,
            keyboardType: type,
            textCapitalization: TextCapitalization.sentences,
            maxLines: lines,
            cursorColor: cor_do_app,
            style: GoogleFonts.quicksand(fontSize: 16),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
