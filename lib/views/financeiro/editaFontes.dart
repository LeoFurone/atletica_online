import 'package:atletica_online/components/myAppBar.dart';
import 'package:atletica_online/components/myCircularProgress.dart';
import 'package:atletica_online/components/tituloSessao.dart';
import 'package:atletica_online/controllers/financeiro/editaFontesController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditaFontes extends StatelessWidget {
  final EditaFontesController editaFontesController =
      Get.put(EditaFontesController());

  Future<QuerySnapshot> trazerFontesAtivas() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('financeiro')
        .doc('fontes')
        .collection('dados')
        .where('ativa', isEqualTo: true)
        .get();
    return querySnapshot;
  }

  Future<QuerySnapshot> trazerFontesNaoAtivas() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('financeiro')
        .doc('fontes')
        .collection('dados')
        .where('ativa', isEqualTo: false)
        .get();
    return querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('financeiro')
        .doc('fontes')
        .collection('dados')
        .snapshots()
        .listen((event) {
      trazerFontesAtivas().then((QuerySnapshot snapshot) {
        editaFontesController.atualizarDocumentosAtivos(snapshot.docs);
      });

      trazerFontesNaoAtivas().then((QuerySnapshot snapshot) {
        editaFontesController.atualizarDocumentosNaoAtivos(snapshot.docs);
      });
    });

    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var safeArea = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyAppBar(
            title: 'OPÇÕES DE FONTE FINANCEIRA',
            back: true,
          ),
          SizedBox(height: 8),
          Container(
            width: widthScreen,
            child: GetBuilder<EditaFontesController>(builder: (_) {
              if (editaFontesController.documentsAtivos == null) {
                return Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  child: MyCircularProgress(),
                );
              } else {
                if (editaFontesController.documentsAtivos!.length != 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TituloSessao(titulo: 'Fontes Ativas'),
                      Wrap(
                        children: List<Widget>.generate(
                            editaFontesController.documentsAtivos!.length,
                            (int index) {
                          return itemFonte(editaFontesController
                              .documentsAtivos![index]['descricao']);
                        }),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              }
            }),
          ),
          SizedBox(height: 16),
          Container(
            width: widthScreen,
            child: GetBuilder<EditaFontesController>(
              builder: (_) {
                if (editaFontesController.documentsAtivos == null) {
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: MyCircularProgress(),
                  );
                } else {
                  if (editaFontesController.documentsNaoAtivos.length != 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TituloSessao(titulo: 'Fontes Não Ativas'),
                        Wrap(
                          children: List<Widget>.generate(
                              editaFontesController.documentsNaoAtivos.length,
                              (int index) {
                            return itemFonte(editaFontesController
                                .documentsNaoAtivos[index]['descricao']);
                          }),
                        ),
                        SizedBox(height: 16),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }
              },
            ),
          ),
          Center(
            child: Container(
              width: widthScreen - 16,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.only(right: 4, top: 8, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(FontAwesomeIcons.exclamationCircle),
                    ),
                    Expanded(
                      flex: 9,
                      child: Text(
                          'Atenção: para ver as opções da fonte (ativa/não ativa) fique segurando a opção desejada.',
                          style: GoogleFonts.quicksand(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: Container(
              width: widthScreen - 16,
              child: botaoContorno(
                Text('Adicionar Nova Fonte'.toUpperCase(),
                style: GoogleFonts.montserrat(color: Colors.green, letterSpacing: 1, fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center, ),
                Colors.green,
                FontAwesomeIcons.plusCircle,
                () => print('oi'),
                botaoMaior: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding itemFonte(String titulo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            titulo,
            style: GoogleFonts.quicksand(fontSize: 18),
          ),
        ),
      ),
    );
  }

  InkWell botaoContorno(Text texto, Color cor, IconData icon, Function()? onTap,
      {double height = 32, bool botaoMaior = false}) {
    return InkWell(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: cor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              botaoMaior == false
                  ? Row(
                    children: [
                      Icon(icon, size: 32, color: cor),
                      SizedBox(width: 8),
                    ],
                  )
                  : Container(),
              Expanded(
                child: Container(
//                  color: Colors.blue,
//                  height: height,
                  child: texto,
                ),
              )
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
