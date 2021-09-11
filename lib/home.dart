import 'package:atletica_online/components/myAppBar.dart';
import 'package:atletica_online/components/myCircularProgress.dart';
import 'package:atletica_online/views/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'views/financeiro/financeiro.dart';
import 'package:atletica_online/views/opcoes.dart';
import 'package:atletica_online/views/patrimonio.dart';
import 'package:atletica_online/views/atividades.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:atletica_online/components/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controllers/menuController.dart';

class Home extends StatelessWidget {
  final TextEditingController codigoAtletica = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final MenuController menuController = Get.put(MenuController());

    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var safeArea = MediaQuery.of(context).padding.top;

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
      Patrimonio(
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
          if (snapshot.data!.exists) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return GetBuilder<MenuController>(
                  init: MenuController(),
                  builder: (_) {
                    String atletica = snapshot.data!['atletica'];
                    atletica != '' ? menuController.atualizarTemAtletica(true):menuController.atualizarTemAtletica(false);

                    if(menuController.temAtletica) {
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
                            color: azul_principal,
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
                                    init: MenuController(),
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
                                    init: MenuController(),
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
                                    init: MenuController(),
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
                                  onTap: () {
                                    menuController.atualizarIndex(3);
                                  },
                                  child: GetBuilder<MenuController>(
                                    init: MenuController(),
                                    builder: (_) {
                                      return itemMenu(
                                          heightScreen,
                                          FontAwesomeIcons.boxOpen,
                                          'Patrimônio',
                                          3,
                                          menuController.index);
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    menuController.atualizarIndex(4);
                                  },
                                  child: GetBuilder<MenuController>(
                                    init: MenuController(),
                                    builder: (_) {
                                      return itemMenu(
                                          heightScreen,
                                          FontAwesomeIcons.cog,
                                          'Opções',
                                          4,
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
                      return Scaffold(
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
                          ],
                        ),
                      );
                    }

                  },
                );
              case ConnectionState.waiting:
                return Scaffold(
                  body: Container(
                    alignment: Alignment.center,
                    child: MyCircularProgress(),
                  ),
                );
              default:
                return Text('vai saber');
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
            return Scaffold(
              body: Container(
                alignment: Alignment.center,
                child: MyCircularProgress(),
              ),
            );
          }
        } else {
          return Scaffold(
            body: Container(
              alignment: Alignment.center,
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
