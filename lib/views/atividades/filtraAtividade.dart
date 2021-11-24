import 'package:atletica_online/components/colors.dart';
import 'package:atletica_online/components/dialogs/adicionaTag.dart';
import 'package:atletica_online/components/dialogs/confirmacao.dart';
import 'package:atletica_online/components/myAppBar.dart';
import 'package:atletica_online/components/myCircularProgress.dart';
import 'package:atletica_online/controllers/atividades/atividadeController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:atletica_online/globals.dart' as globals;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FiltraAtividades extends StatelessWidget {
  final List<dynamic> atividades;
  final List<dynamic> atividadesNaoResolvidas;

  final AtividadeController atividadeController = Get.find();

  FiltraAtividades({Key? key, required this.atividades, required this.atividadesNaoResolvidas}) : super(key: key);

  Future<QuerySnapshot> trazerTags() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('atleticas')
        .doc(globals.atletica_firebase)
        .collection('tags_atividades')
        .get();
    return querySnapshot;
  }

  void filtrarAtividades(String tag) {
    List newAtividades = [];

    for (int i = 0; i < atividades.length; i++) {
      if (atividades[i]['tag'].toLowerCase() == tag.toLowerCase() && atividades[i]['concluida'] == false) {
        newAtividades.add(atividades[i]);
      }
    }

    atividadeController.atualizaTagSelecionada(tag);
    atividadeController.atualizaAtividades(newAtividades);
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('atleticas')
        .doc(globals.atletica_firebase)
        .collection('tags_atividades')
        .snapshots()
        .listen((event) async {
      QuerySnapshot querySnapshot = await trazerTags();
      atividadeController.atualizaTags(List.from(querySnapshot.docs));
    });

    var widthScreen = MediaQuery
        .of(context)
        .size
        .width;
    var heightScreen = MediaQuery
        .of(context)
        .size
        .height;
    var safeArea = MediaQuery
        .of(context)
        .padding
        .top;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyAppBar(title: 'TAGS', back: true),
            SizedBox(height: safeArea),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: FutureBuilder<QuerySnapshot>(
                  future: trazerTags(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      atividadeController.atualizaTags(List.from(snapshot.data!.docs));
                      return GetBuilder<AtividadeController>(
                        builder: (_) {
                          return atividadeController.tags.length > 0
                              ? Container(
                            width: widthScreen,
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: List<Widget>.generate(
                                  atividadeController.tags.length, (int index) {
                                return GestureDetector(
                                  onTap: () {
                                    filtrarAtividades(atividadeController.tags[atividadeController.tags.length - index -1]['titulo']);
                                    Get.back();
                                  },
                                  onLongPress: () {
                                    Get.dialog(Confirmacao(excluirDados: () async {
                                      DocumentReference exclusao = FirebaseFirestore.instance
                                          .collection('atleticas')
                                          .doc(globals.atletica_firebase)
                                          .collection('tags_atividades')
                                          .doc(atividadeController
                                          .tags[atividadeController.tags.length - index -1].id);

                                      await exclusao.delete();
                                      Get.back();

                                    },));
                                  },
                                  child: atividadeController.tag.toUpperCase() == atividadeController.tags[atividadeController.tags.length - index -1]['titulo'].toString().toUpperCase() ? Container(
                                    color: Colors.grey[400],
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        atividadeController
                                            .tags[atividadeController.tags.length - index -1]['titulo']
                                            .toString()
                                            .toUpperCase(),
                                        style: GoogleFonts.quicksand(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ) : Container(
                                    color: Colors.grey[200],
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        atividadeController
                                            .tags[atividadeController.tags.length - index -1]['titulo']
                                            .toString()
                                            .toUpperCase(),
                                        style: GoogleFonts.quicksand(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          )
                              : Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8, left: 0, top: 8),
                            child: Container(
                              width: widthScreen - 16,
                              child: Column(
                                children: [
                                  Icon(FontAwesomeIcons.exclamation,
                                      size: 48, color: cor_do_app),
                                  SizedBox(height: 8),
                                  Text(
                                    'Não há nenhuma tag cadastrada!',
                                    style: GoogleFonts.quicksand(
                                      color: cor_do_app,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        child: MyCircularProgress(),
                      );
                    }
                  }),
            ),

            SizedBox(height: 16),
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
                            'Atenção: para excluir uma tag, fique segurando a opção desejada.',
                            style: GoogleFonts.quicksand(
                                fontSize: 14, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: InkWell(
                onTap: () {
                  atividadeController.atualizaAtividades(atividadesNaoResolvidas);
                  atividadeController.atualizaTagSelecionada('');
                  Get.back();
                },
                child: Container(
                  width: widthScreen - 16,
                  height: 40,
                  decoration: BoxDecoration(
                    color: cor_do_app,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Limpar tag'.toUpperCase(),
                      style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: InkWell(
                onTap: () {
                  Get.dialog(AdicionaTag());
                },
                child: Container(
                  width: widthScreen - 16,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: cor_do_app),
                  ),
                  child: Center(
                    child: Text(
                      'ADICIONAR NOVA TAG'.toUpperCase(),
                      style: GoogleFonts.quicksand(
                        color: cor_do_app,
                        fontSize: 20,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
