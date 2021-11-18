import 'package:atletica_online/components/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login/login.dart';

class Opcoes extends StatelessWidget {

  final double heightScreen;
  final double widthScreen;
  final double safeArea;

  const Opcoes({Key? key, required this.heightScreen, required this.widthScreen, required this.safeArea}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightScreen - (heightScreen * 0.1) + 15,
      width: widthScreen,
      color: Colors.grey[100],
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: safeArea),
            GestureDetector(
              onTap: () {
                Get.dialog(MaterialApp(
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: Text(
                                'Deseja realmente sair?',
                                style: GoogleFonts.quicksand(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 4),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Você precisará de Internet para se conectar novamente.',
                                style: GoogleFonts.quicksand(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 32),
                            GestureDetector(
                              onTap: () async {
//                                        Get.back();
                                await FirebaseAuth.instance.signOut();
                                Get.offAll(Login());
                              },
                              child: Container(
                                width: widthScreen * 0.8,
                                height: 60,
                                color: Colors.grey[100],
                                alignment: Alignment.center,
                                child: Text(
                                  'Sair',
                                  style: GoogleFonts.quicksand(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                Get.back();
                              },
                              child: Container(
                                width: widthScreen * 0.8,
                                height: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    )),
                                child: Text(
                                  'Cancelar',
                                  style: GoogleFonts.quicksand(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  debugShowCheckedModeBanner: false,
                ));
              },
              child: Container(
                  height: 70,
                  width: widthScreen,
                  color: Colors.grey[100],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 8),
                      Icon(Icons.power_settings_new),
                      SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sair',
                            style: GoogleFonts.quicksand(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: cor_do_app
                            ),
                          ),
                          Text(
                              'Saia da sua conta atual')
                        ],
                      )
                    ],
                  )),
            ),
            Container(
              width: widthScreen - 32,
              height: 0.7,
              color: Colors.grey,
            ),
            Container(
                height: 70,
                width: widthScreen,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 8),
                    Icon(FontAwesomeIcons.infoCircle ,),
                    SizedBox(width: 8),
                    Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Título opções',
                          style: GoogleFonts.quicksand(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: cor_do_app
                          ),
                        ),
                        Text(
                            'Descrição que vai ser apresentada embaixo')
                      ],
                    )
                  ],
                )),
            Container(
              width: widthScreen - 32,
              height: 0.7,
              color: Colors.grey,
            ),
            Container(
                height: 70,
                width: widthScreen,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 8),
                    Icon(FontAwesomeIcons.infoCircle ,),
                    SizedBox(width: 8),
                    Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Título opções',
                          style: GoogleFonts.quicksand(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: cor_do_app
                          ),
                        ),
                        Text(
                            'Descrição que vai ser apresentada embaixo')
                      ],
                    )
                  ],
                )),
            Container(
              width: widthScreen - 32,
              height: 0.7,
              color: Colors.grey,
            ),
            Container(
                height: 70,
                width: widthScreen,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 8),
                    Icon(FontAwesomeIcons.infoCircle ,),
                    SizedBox(width: 8),
                    Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Título opções',
                          style: GoogleFonts.quicksand(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: cor_do_app
                          ),
                        ),
                        Text(
                            'Descrição que vai ser apresentada embaixo')
                      ],
                    )
                  ],
                )),
            Container(
              width: widthScreen - 32,
              height: 0.7,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
