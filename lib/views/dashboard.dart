import 'package:atletica_online/components/breakpoints.dart';
import 'package:atletica_online/components/dialogs/aviso.dart';
import 'package:atletica_online/components/myCircularProgress.dart';
import 'package:atletica_online/components/myCircularProgressBranco.dart';
import 'package:atletica_online/components/tituloSessao.dart';
import 'package:atletica_online/controllers/dashboardController.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:atletica_online/components/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atletica_online/globals.dart' as globals;

class Dashboard extends StatelessWidget {
  final DashboardController dashboardController =
      Get.put(DashboardController());
  final double heightScreen;
  final double widthScreen;
  final double safeArea;

  Future<List<QueryDocumentSnapshot>> trazerDadosDashboard() async {
    QuerySnapshot querySnapshotGastos = await FirebaseFirestore.instance
        .collection('atleticas')
        .doc(globals.atletica_firebase)
        .collection('financeiro')
        .doc('gastos')
        .collection('dados')
        .get();

    QuerySnapshot querySnapshotRecebidos = await FirebaseFirestore.instance
        .collection('atleticas')
        .doc(globals.atletica_firebase)
        .collection('financeiro')
        .doc('recebidos')
        .collection('dados')
        .get();

    QuerySnapshot querySnapshotAtividades = await FirebaseFirestore.instance
        .collection('atleticas')
        .doc(globals.atletica_firebase)
        .collection('atividades')
        .where('concluida', isEqualTo: true)
        .get();

    List<QueryDocumentSnapshot> atividades;
    if (querySnapshotAtividades.docs.length > 5) {
      atividades = querySnapshotAtividades.docs.sublist(
          querySnapshotAtividades.docs.length - 6,
          querySnapshotAtividades.docs.length - 1);
    } else {
      atividades = querySnapshotAtividades.docs;
    }

    List<QueryDocumentSnapshot> recebidos;
    if (querySnapshotRecebidos.docs.length > 5) {
      recebidos = querySnapshotRecebidos.docs.sublist(
          querySnapshotRecebidos.docs.length - 6,
          querySnapshotRecebidos.docs.length - 1);
    } else {
      recebidos = querySnapshotRecebidos.docs;
    }

    List<QueryDocumentSnapshot> gastos;
    if (querySnapshotGastos.docs.length > 5) {
      gastos = querySnapshotGastos.docs.sublist(
          querySnapshotGastos.docs.length - 6,
          querySnapshotGastos.docs.length - 1);
    } else {
      gastos = querySnapshotGastos.docs;
    }

    List<QueryDocumentSnapshot> dados = List.from(atividades)
      ..addAll(recebidos)
      ..addAll(gastos);

    int n = dados.length;
    for (int j = 0; j < n - 1; j++) {
      for (int i = 0; i < n - 1; i++) {
        DateTime hora1 = DateTime.parse(dados[i]['hora_conclusao']);
        DateTime hora2 = DateTime.parse(dados[i + 1]['hora_conclusao']);
        if (hora1.isAfter(hora2)) {
          QueryDocumentSnapshot aux = dados[i + 1];
          dados[i + 1] = dados[i];
          dados[i] = aux;
        }
      }
    }

    return List.from(dados.reversed);
  }

  Dashboard(
      {Key? key,
      required this.heightScreen,
      required this.widthScreen,
      required this.safeArea})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightScreen - (heightScreen * 0.1) + 15,
      width: widthScreen,
      color: Colors.grey[100],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: safeArea,
              width: widthScreen,
              color: cor_do_app,
            ),
            SizedBox(height: 8),
            Container(
              height: 40,
              width: widthScreen,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TituloSessao(titulo: "acontecimentos recentes"),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: GetBuilder<DashboardController>(
                          builder: (_) {
                            return Text(
                              'Atualizado as ' + dashboardController.hora_atual,
                              style: GoogleFonts.raleway(
                                  fontSize: 16,
                                  color: cor_do_app
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      List<QueryDocumentSnapshot> sync = await trazerDadosDashboard();
                      dashboardController.atualizaHora();
                      dashboardController.atualizaLista(sync);
                      Get.dialog(Aviso(
                        titulo: "Atualizado com sucesso!",
                        subTitulo: "Seus acontecimentos recentes foram atualizados.",
                        color: Colors.green,
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(Icons.sync, size: 40, color: cor_do_app),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 8),
            FutureBuilder<List<QueryDocumentSnapshot>>(
                future: trazerDadosDashboard(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      dashboardController.atualizaLista(snapshot.data!);

                      return GetBuilder<DashboardController>(
                        builder: (_) {
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: dashboardController.lista.length,
                            itemBuilder: (context, index) {
                              String mes = dashboardController.lista[index]
                                      ['hora_conclusao']
                                  .substring(5, 7);
                              String dia = dashboardController.lista[index]
                                      ['hora_conclusao']
                                  .substring(8, 10);

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: corAcontecimento(
                                                dashboardController
                                                    .lista[index]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                          ),
                                          child: verificaIcone(
                                              dashboardController.lista[index]),
                                        ),
                                        SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: widthScreen - 24 - 40 - 16,
                                              child: Text(
                                                  titulo(dashboardController
                                                      .lista[index]),
                                                  style: GoogleFonts.raleway(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  )),
                                            ),
                                            SizedBox(height: 4),
                                            Container(
                                              width: widthScreen - 24 - 40 - 16,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                      child: Row(
                                                    children: [
                                                      Icon(
                                                          FontAwesomeIcons.user,
                                                          size: 14),
                                                      SizedBox(width: 4),
                                                      Text(
                                                        dashboardController
                                                                .lista[index]
                                                            ['responsavel'],
                                                        style:
                                                            GoogleFonts.raleway(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          dia +
                                                              '/' +
                                                              mes +
                                                              ' - ' +
                                                              formataHora(DateTime.parse(
                                                                  dashboardController
                                                                              .lista[
                                                                          index]
                                                                      [
                                                                      'hora_conclusao'])),
                                                          style: GoogleFonts
                                                              .raleway(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        SizedBox(width: 4),
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .clock,
                                                          size: 14,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return Text('erro');
                    }
                  } else {
                    return Container(
                      height: heightScreen / 2,
                      alignment: Alignment.center,
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        child: MyCircularProgress(),
                      ),
                    );
                  }
                }),
//            InkWell(
//              onTap: () async {
//                List<QueryDocumentSnapshot> teste = await trazerDadosDashboard();
//                dashboardController.atualizaLista(teste);
//              },
//              child: Container(
//                height: 100,
//                width: 100,
//                color: Colors.black,
//              ),
//            )
          ],
        ),
      ),
    );
  }

  String titulo(QueryDocumentSnapshot dado) {
    if (dado['tipo'] == 'atv') {
      return 'A seguinte atividade foi concluida: ' + dado['titulo'];
    }

    if (dado['tipo'] == 'gasto') {
      return 'Foi gasto o valor de R\$' +
          dado['valor'].toString().replaceAll('.', ',') +
          '.';
    }

    if (dado['tipo'] == 'recebido') {
      return 'Foi recebido o valor de R\$' +
          dado['valor'].toString().replaceAll('.', ',') +
          '.';
    }
    return 'Erro!';
  }

  String formataHora(DateTime hora) {
    return arrumaTamanhoDaData(hora.hour.toString()) +
        ':' +
        arrumaTamanhoDaData(hora.minute.toString());
  }

  String arrumaTamanhoDaData(String data) {
    if (data.length == 1) {
      String nova = '0' + data;
      return nova;
    } else {
      return data;
    }
  }

  Color corAcontecimento(QueryDocumentSnapshot dado) {
    if (dado['tipo'] == 'atv') {
      return cor_do_app;
    }

    if (dado['tipo'] == 'gasto') {
      return vermelho_secundario;
    }

    if (dado['tipo'] == 'recebido') {
      return Colors.green;
    }

    return Colors.black;
  }

  Icon verificaIcone(QueryDocumentSnapshot dado) {
    if (dado['tipo'] == 'atv') {
      return Icon(FontAwesomeIcons.check, color: Colors.white);
    }

    if (dado['tipo'] == 'recebido') {
      return Icon(FontAwesomeIcons.dollarSign, color: Colors.white);
    }

    if (dado['tipo'] == 'gasto') {
      return Icon(FontAwesomeIcons.dollarSign, color: Colors.white);
    }

    return Icon(Icons.error);
  }

  Padding itemReunioes(String titulo, String data, String hora) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: cor_do_app,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        data.substring(0, 2),
                        style: GoogleFonts.montserrat(color: Colors.white),
                      ),
                      Text(
                        data.substring(3, 5),
                        style: GoogleFonts.montserrat(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4),
              SizedBox(
                width: widthScreen < 768 ? widthScreen / 4 : widthScreen / 8,
                child: Text(
                  titulo.toUpperCase(),
                  style: GoogleFonts.quicksand(
                    color: cor_do_app,
                    letterSpacing: 1.25,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 4),
              SizedBox(
                width: widthScreen < tablet ? widthScreen / 4 : widthScreen / 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.clock, size: 12),
                    SizedBox(width: 4),
                    Text(
                      hora,
                      style: GoogleFonts.quicksand(
                        color: Colors.black,
                        letterSpacing: 1.25,
                        fontSize: 10,
                      ),
                      maxLines: 3,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
