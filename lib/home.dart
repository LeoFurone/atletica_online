import 'package:atletica_online/components/myAppBar.dart';
import 'package:atletica_online/components/myCircularProgress.dart';
import 'package:atletica_online/views/dashboard.dart';
import 'package:atletica_online/views/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'views/financeiro/financeiro.dart';
import 'package:atletica_online/views/opcoes.dart';
import 'package:atletica_online/views/patrimonio.dart';
import 'views/atividades/atividades.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:atletica_online/components/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atletica_online/globals.dart' as globals;

import 'controllers/menuController.dart';

class Home extends StatelessWidget {
  final TextEditingController codigoAtletica = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final MenuController menuController = Get.put(MenuController());

    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var safeArea = MediaQuery.of(context).padding.top;

    String? atletica;

    List<Widget> telas = [
      Dashboard(
          heightScreen: heightScreen,
          widthScreen: widthScreen,
          safeArea: safeArea),
      Financeiro(
          heightScreen: heightScreen,
          widthScreen: widthScreen,
          safeArea: safeArea),
      Atividades(
          heightScreen: heightScreen,
          widthScreen: widthScreen,
          safeArea: safeArea),
      Opcoes(
          heightScreen: heightScreen,
          widthScreen: widthScreen,
          safeArea: safeArea)
    ];

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('mapeamento').doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GetBuilder<MenuController>(
            builder: (_) {
              if (snapshot.data!.exists || menuController.criouUsuario) {

                if(menuController.criouUsuario && FirebaseAuth.instance.currentUser!.uid != null) {
                  FirebaseFirestore.instance.collection('mapeamento').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
                    atletica = value['atletica'];
                  });
                } else {
                  atletica = snapshot.data!['atletica'];
                }
                atletica == '' || atletica == null? menuController.atualizarTemAtletica(false):menuController.atualizarTemAtletica(true);

                if(menuController.temAtletica) {

                  globals.atletica_firebase = atletica;


                  return Scaffold(
                    body: Container(
                      width: widthScreen,
                      alignment: Alignment.topCenter,
                      child: GetBuilder<MenuController>(
                          builder: (_) {
                            return IndexedStack(
                              children: telas,
                              index: menuController.index,
                            );
                          }),
                    ),
                    bottomNavigationBar: Container(
                      height: heightScreen * 0.1,
                      width: widthScreen,
                      decoration: BoxDecoration(
                        color: cor_do_app,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                menuController.atualizarIndex(0);
                              },
                              child: GetBuilder<MenuController>(
                                builder: (_) {
                                  return itemMenu(
                                      heightScreen,
                                      FontAwesomeIcons.home,
                                      'Home',
                                      0,
                                      menuController.index);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                menuController.atualizarIndex(1);
                              },
                              child: GetBuilder<MenuController>(
                                builder: (_) {
                                  return itemMenu(
                                      heightScreen,
                                      FontAwesomeIcons.dollarSign,
                                      'Financeiro',
                                      1,
                                      menuController.index);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                menuController.atualizarIndex(2);
                              },
                              child: GetBuilder<MenuController>(
                                builder: (_) {
                                  return itemMenu(
                                      heightScreen,
                                      FontAwesomeIcons.calendarAlt,
                                      'Atividades',
                                      2,
                                      menuController.index);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
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
                                                menuController.atualizarIndex(0);
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
                              child: GetBuilder<MenuController>(
                                builder: (_) {
                                  return itemMenu(
                                      heightScreen,
                                      Icons.power_settings_new,
                                      'Sair',
                                      3,
                                      menuController.index);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: Scaffold(
                      body: Column(
                        children: [
                          MyAppBar(
                            title: 'Código da Atlética',
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Coloque o código da sua Associação Atlética para ser incluído dentro de sua organização.',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  letterSpacing: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          TextField(controller: codigoAtletica),
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: () async {
                              FocusScopeNode currentFocus = FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }

                              if(codigoAtletica.text != "") {

                                DocumentSnapshot existe_atletica = await FirebaseFirestore.instance.collection('atleticas').doc(codigoAtletica.text).get();

                                if(existe_atletica.exists) {
                                  DocumentSnapshot atualizar_atletica = await FirebaseFirestore.instance.collection('mapeamento').doc(FirebaseAuth.instance.currentUser!.uid).get();
                                  await atualizar_atletica.reference.update({
                                    "admin": false,
                                    "atletica": codigoAtletica.text,
                                  });
                                  Get.offAll(() => Home());
                                } else {
                                  print('atletica não existente');
                                }
                              } else {
                                print('em branco');
                              }



                            },
                            child: Container(
                              height: 40,
                              width: widthScreen / 2,
                              color: cor_do_app,
                              alignment: Alignment.center,
                              child: Text(
                                'Entrar'.toUpperCase(),
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    letterSpacing: 2.5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              } else {
                CollectionReference collectionReference =
                FirebaseFirestore.instance.collection('mapeamento');
                collectionReference
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .set({
                  "admin": false,
                  "atletica": "",
                });
                menuController.atualizarCriouUsuario(true);
                return Scaffold(
                  body: Container(
                    alignment: Alignment.center,
//                    child: Text('teste 2'),
                child: MyCircularProgress(),
                  ),
                );
              }
            },
          );
        } else {
          return Scaffold(
            body: Container(
              alignment: Alignment.center,
//              child: Text('teste 1'),
              child: MyCircularProgress(),
            ),
          );
        }
      },
    );
  }

  Container itemMenu(double heightScreen, dynamic icon, String name,
      int indexItem, int index) {
    return Container(
      height: heightScreen * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              icon,
              color: indexItem == index ? Colors.white : Colors.grey[400],
              size: heightScreen * 0.048 - 12,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          AutoSizeText(
            name,
            style: GoogleFonts.quicksand(
              color: indexItem == index ? Colors.white : Colors.grey[400],
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
          )
        ],
      ),
    );
  }

}
