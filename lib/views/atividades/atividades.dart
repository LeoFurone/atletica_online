import 'package:atletica_online/components/colors.dart';
import 'package:atletica_online/components/dialogs/aviso.dart';
import 'package:atletica_online/components/dialogs/confirmacao.dart';
import 'package:atletica_online/components/dialogs/opcoesTarefas.dart';
import 'package:atletica_online/components/dialogs/vazio.dart';
import 'package:atletica_online/components/myCircularProgress.dart';
import 'package:atletica_online/controllers/DashboardController.dart';
import 'package:atletica_online/controllers/atividades/atividadeController.dart';
import 'package:atletica_online/views/atividades/criaAtividade.dart';
import 'package:atletica_online/views/atividades/filtraAtividade.dart';
import 'package:atletica_online/views/atividades/visualizaAtividade.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atletica_online/globals.dart' as globals;
import 'package:grouped_list/grouped_list.dart';

class Atividades extends StatelessWidget {
  final AtividadeController atividadeController = Get.put(AtividadeController());
  final double heightScreen;
  final double widthScreen;
  final double safeArea;
  List<dynamic> atvResolvidas = [];


  Atividades(
      {Key? key,
      required this.heightScreen,
      required this.widthScreen,
      required this.safeArea})
      : super(key: key);

  Future<QuerySnapshot> trazerAtividades() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('atleticas')
        .doc(globals.atletica_firebase)
        .collection('atividades')
        .get();
    return querySnapshot;
  }

  int verificaTamanhoAtividade(dynamic atividade) {
    int interessadosEResponsaveis = 0;
    int qtd_interessados = atividade['interessados'].length;

    atividade['responsavel'] != ''
        ? interessadosEResponsaveis = interessadosEResponsaveis + 1
        : interessadosEResponsaveis;
    interessadosEResponsaveis = interessadosEResponsaveis + qtd_interessados;

    return interessadosEResponsaveis;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('atleticas')
        .doc(globals.atletica_firebase)
        .collection('atividades')
        .snapshots()
        .listen((event) async {
      QuerySnapshot querySnapshot = await trazerAtividades();
      atividadeController.atualizaAtividadesFirebase(List.from(querySnapshot.docs));

      atvResolvidas.clear();

      for(int n = 0 ; n < atividadeController.atividadesFirebase.length ; n++) {
        if(atividadeController.atividadesFirebase[n]['concluida'] == false) {
          atvResolvidas.add(atividadeController.atividadesFirebase[n]);
        }
      }

      if(atividadeController.tag != ''){
        List newAtividades = [];
        for (int i = 0; i < atvResolvidas.length; i++) {
          if (atvResolvidas[i]['tag'].toLowerCase() == atividadeController.tag.toLowerCase()) {
            newAtividades.add(atvResolvidas[i]);
          }
        }
        atividadeController.atualizaAtividades(newAtividades);
      } else {
        atividadeController.atualizaAtividades(atvResolvidas);
      }


    });

    return Stack(
      children: [
        Container(
          height: heightScreen - (heightScreen * 0.1) + 15,
          width: widthScreen,
          color: Colors.grey[100],
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: safeArea),
                FutureBuilder<QuerySnapshot>(
                  future: trazerAtividades(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      atividadeController.atualizaAtividadesFirebase(List.from(snapshot.data!.docs));

                      return GetBuilder<AtividadeController>(
                        builder: (_) {

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              seleciona_diretorias(atividadeController.atividadesFirebase,atvResolvidas),
//                              false
                              atividadeController.atividades.length > 0
                                  ? Container(
                                      child: GroupedListView(
                                        padding: const EdgeInsets.only(top: 0),
                                        shrinkWrap: true,
                                        elements: atividadeController.atividades,
                                        order: GroupedListOrder.ASC,
                                        groupBy: (dynamic? element) =>
                                            element['prazo'],
                                        itemBuilder: (context, element) {
                                          return InkWell(
                                            onTap: () {
                                              Get.to(
                                                  () => VisualizaAtividade(atividade: element),
                                                  transition:
                                                      Transition.rightToLeft);
                                            },
                                            child: tarefa(element),
                                          );
                                        },
                                        groupSeparatorBuilder:
                                            _buildGroupSeparator,
                                      ),
                                    )
                                  : Container(
                                      width: widthScreen,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 32),
                                          Icon(FontAwesomeIcons.exclamation,
                                              size: 160, color: cor_do_app),
                                          SizedBox(height: 32),
                                          Text(
                                            'Nenhuma atividade encontrada',
                                            style: GoogleFonts.quicksand(
                                              color: cor_do_app,
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
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
                  },
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: 8,
          bottom: 8,
          child: GestureDetector(
            onTap: () {
              Get.to( () => CriaAtividade());
//              Get.dialog(OpcoesTarefas());
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: cor_do_app,
                borderRadius: BorderRadius.circular(300),
              ),
              child: Icon(
                FontAwesomeIcons.plus,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  Padding seleciona_diretorias(List<dynamic> atv, List<dynamic> atvNaoResolvidas) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'ATIVIDADES'.toUpperCase(),
            style: GoogleFonts.raleway(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: cor_do_app),
          ),
          InkWell(
              onTap: () {
                Get.to(() => FiltraAtividades(atividades: atv, atividadesNaoResolvidas: atvNaoResolvidas),
                    transition: Transition.rightToLeft);
              },
              child: Icon(FontAwesomeIcons.filter, color: cor_do_app))
        ],
      ),
    );
  }

  Text titulo_sessao() {
    return Text(
      '06/04',
      style: GoogleFonts.quicksand(),
    );
  }

  Container tarefa(dynamic atividade) {
    return Container(
      width: widthScreen - 16,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: Text(
                    atividade['titulo'],
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    atividade['descricao'],
                    style: GoogleFonts.quicksand(fontSize: 12),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 60,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.dialog(Confirmacao(excluirDados: () async  {
                        DocumentReference documentReference = FirebaseFirestore.instance
                            .collection('atleticas')
                            .doc(globals.atletica_firebase)
                            .collection('atividades')
                            .doc(atividade.id);

                        await documentReference.delete();
                        Get.back();
                      }));



                    },
                    child: Icon(FontAwesomeIcons.trash, color: Colors.black,),
                  ),
                  InkWell(
                    onTap: () async {
                      DocumentReference documentReference = FirebaseFirestore.instance
                          .collection('atleticas')
                          .doc(globals.atletica_firebase)
                          .collection('atividades')
                          .doc(atividade.id);

                      await documentReference.update({
                        "concluida": !atividade['concluida'],
                        "hora_conclusao": DateTime.now().toString(),
                        "tipo": 'atv',
                      });

                      Get.dialog(Aviso(
                        titulo: "Sua atividade foi concluída!",
                        subTitulo: "Sendo assim, ela não aparecerá mais na aba de atividades.",
                        color: Colors.green,
                      ));

                    },
                    child: Icon(FontAwesomeIcons.check, color: Colors.black),
                  ),
                ],
              ),
            ),
          )
//          SizedBox(
//            width: 110,
//            height: 40,
//            child: Container(
//              alignment: Alignment.centerRight,
//              child: ListView.builder(
//                scrollDirection: Axis.horizontal,
//                padding: EdgeInsets.all(0),
//                shrinkWrap: true,
//                physics: NeverScrollableScrollPhysics(),
//                itemCount: verificaTamanhoAtividade(atividade),
//                itemBuilder: (context, index) {
//                  return Align(
//                    widthFactor: 0.85,
//                    alignment: Alignment.centerRight,
//                    child: Container(
//                      child: ClipRRect(
//                        borderRadius: BorderRadius.circular(300),
//                        child: Container(
//                          height: 40,
//                          child: Image.asset('assets/images/appeu.jpg'),
//                        ),
//                      ),
//                    ),
//                  );
//                },
//              ),
//            ),
//          ),
        ],
      ),
    );
  }

  Widget _buildGroupSeparator(dynamic groupByValue) {
    String date = groupByValue;
    String monthNumber = date.substring(5, 7);
    String year = date.substring(0, 4);
    String day = date.substring(8, 10);

    String data = day + '/' + monthNumber + '/' + year;

    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 4),
//      padding: const EdgeInsets.only(vertical: 8, horizontal: 16),
      child: Text(
        data.toUpperCase(),
        style: GoogleFonts.quicksand(),
      ),
    );
  }
}
