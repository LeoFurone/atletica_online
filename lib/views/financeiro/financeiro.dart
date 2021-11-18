import 'package:atletica_online/components/colors.dart';
import 'package:atletica_online/components/dialogs/opcoesFinanceiro.dart';
import 'package:atletica_online/components/myCircularProgress.dart';
import 'package:atletica_online/components/myCircularProgressBranco.dart';
import 'package:atletica_online/components/tituloSessao.dart';
import 'package:atletica_online/controllers/financeiro/financeiroController.dart';
import 'package:atletica_online/views/financeiro/maisFinanceiro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atletica_online/globals.dart' as globals;

class Financeiro extends StatelessWidget {
  final FinanceiroController financeiroController =
      Get.put(FinanceiroController());

  final double heightScreen;
  final double widthScreen;
  final double safeArea;

  Financeiro(
      {Key? key,
      required this.heightScreen,
      required this.widthScreen,
      required this.safeArea})
      : super(key: key);

  Future<DocumentSnapshot> trazerValorCaixa() async {
    return FirebaseFirestore.instance
        .collection('atleticas')
        .doc(globals.atletica_firebase)
        .collection('financeiro')
        .doc('caixa')
        .get();
  }

  Future<QuerySnapshot> trazerGastos() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('atleticas')
        .doc(globals.atletica_firebase)
        .collection('financeiro')
        .doc('gastos')
        .collection('dados')
        .get();
    return querySnapshot;
  }

  Future<QuerySnapshot> trazerRecebidos() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('atleticas')
        .doc(globals.atletica_firebase)
        .collection('financeiro')
        .doc('recebidos')
        .collection('dados')
        .get();
    return querySnapshot;
  }

  Future<QuerySnapshot> trazerRecebidosMes() async {
    String mesAtual = DateTime.now().toString().substring(5, 7);
    String anoAtual = DateTime.now().toString().substring(0, 4);

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('atleticas')
        .doc(globals.atletica_firebase)
        .collection('financeiro')
        .doc('recebidos')
        .collection('dados')
        .where("mes", isEqualTo: mesAtual)
        .where("ano", isEqualTo: anoAtual)
        .get();
    return querySnapshot;
  }

  Future<QuerySnapshot> trazerGastosMes() async {
    String mesAtual = DateTime.now().toString().substring(5, 7);
    String anoAtual = DateTime.now().toString().substring(0, 4);

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('atleticas')
        .doc(globals.atletica_firebase)
        .collection('financeiro')
        .doc('gastos')
        .collection('dados')
        .where("mes", isEqualTo: mesAtual)
        .where("ano", isEqualTo: anoAtual)
        .get();
    return querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('atleticas')
        .doc(globals.atletica_firebase)
        .collection('financeiro')
        .doc('caixa')
        .snapshots()
        .listen((event) {
      String valor = event['valor'];
      double valorDouble = double.parse(valor);
      financeiroController.atualizarCaixaAtual(valorDouble);

      FirebaseFirestore.instance
          .collection('atleticas')
          .doc(globals.atletica_firebase)
          .collection('financeiro')
          .doc('recebidos')
          .collection('dados')
          .get()
          .then((value) {
        financeiroController
            .atualizarDocumentsRecebidos(List.from(value.docs.reversed));
      });

      var mesAtual = DateTime.now().toString().substring(5, 7);
      var anoAtual = DateTime.now().toString().substring(0, 4);

      FirebaseFirestore.instance
          .collection('atleticas')
          .doc(globals.atletica_firebase)
          .collection('financeiro')
          .doc('gastos')
          .collection('dados')
          .get()
          .then((value) {
        financeiroController
            .atualizarDocumentsGastos(List.from(value.docs.reversed));
      });

      FirebaseFirestore.instance
          .collection('atleticas')
          .doc(globals.atletica_firebase)
          .collection('financeiro')
          .doc('recebidos')
          .collection('dados')
          .where("mes", isEqualTo: mesAtual)
          .where("ano", isEqualTo: anoAtual)
          .get()
          .then((value) {
        QuerySnapshot querySnapshot = value;
        List<QueryDocumentSnapshot> documentsRecebidosMes = [];
        documentsRecebidosMes = querySnapshot.docs;

        double total = 0;
        for (var n = 0; n < documentsRecebidosMes.length; n++) {
          total = total + documentsRecebidosMes[n]['valor'];
        }

        financeiroController.atualizarRecebidosMes(total);
      });

      FirebaseFirestore.instance
          .collection('atleticas')
          .doc(globals.atletica_firebase)
          .collection('financeiro')
          .doc('gastos')
          .collection('dados')
          .where("mes", isEqualTo: mesAtual)
          .where("ano", isEqualTo: anoAtual)
          .get()
          .then((value) {
        QuerySnapshot querySnapshot = value;
        List<QueryDocumentSnapshot> documentsGastosMes = [];
        documentsGastosMes = querySnapshot.docs;

        double total = 0;
        for (var n = 0; n < documentsGastosMes.length; n++) {
          total = total + documentsGastosMes[n]['valor'];
        }

        financeiroController.atualizarGastosMes(total);
      });

    });

    List<QueryDocumentSnapshot> documentsRecebidosMes = [];
    List<QueryDocumentSnapshot> documentsGastosMes = [];

    return Stack(children: [
      Container(
        height: heightScreen - (heightScreen * 0.1) + 15,
        width: widthScreen,
        color: Colors.grey[100],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: safeArea, color: cor_do_app),
              Container(
                width: widthScreen,
                decoration: BoxDecoration(
                    color: cor_do_app,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(30))),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Text(
                      'Caixa Atual'.toUpperCase(),
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    FutureBuilder<DocumentSnapshot>(
                      future: trazerValorCaixa(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          financeiroController.atualizarCaixaAtual(
                              double.parse(snapshot.data!['valor']));
                          return GetBuilder<FinanceiroController>(builder: (_) {
                            return Text(
                              'R\$ ' +
                                  financeiroController.caixa_atual
                                      .toPrecision(2)
                                      .toString()
                                      .replaceAll(".", ',')
                              ,
                              style: GoogleFonts.montserrat(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            );
                          });

                          return Text('erro');
                        } else {
                          return Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            child: MyCircularProgressBranco(),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 32),
                    Text(
                      retornaMesAtual().toUpperCase(),
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 150),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.arrowUp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Recebido'.toUpperCase(),
                                        style: GoogleFonts.quicksand(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      FutureBuilder<QuerySnapshot>(
                                        future: trazerRecebidosMes(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            documentsRecebidosMes =
                                                snapshot.data!.docs;
                                            double valor = 0;
                                            for (var n = 0;
                                                n <
                                                    documentsRecebidosMes
                                                        .length;
                                                n++) {
                                              valor = valor +
                                                  documentsRecebidosMes[n]
                                                      ['valor'];
                                            }
                                            financeiroController
                                                .atualizarRecebidosMes(valor);

                                            return GetBuilder<
                                                FinanceiroController>(
                                              builder: (_) {
                                                return Text(
                                                  'R\$ ' +
                                                      financeiroController
                                                          .recebidos_mes
                                                          .toPrecision(2)
                                                          .toString()
                                                          .replaceAll(".", ',')
                                                  ,
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                              },
                                            );
                                          } else {
                                            return Container(
                                              height: 40,
                                              width: 40,
                                              alignment: Alignment.center,
                                              child: MyCircularProgressBranco(),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 150),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Gasto'.toUpperCase(),
                                        style: GoogleFonts.quicksand(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      FutureBuilder<QuerySnapshot>(
                                        future: trazerGastosMes(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            documentsGastosMes =
                                                snapshot.data!.docs;

                                            double valor = 0;
                                            for (var n = 0;
                                                n < documentsGastosMes.length;
                                                n++) {
                                              valor = valor +
                                                  documentsGastosMes[n]
                                                      ['valor'];
                                            }
                                            financeiroController
                                                .atualizarGastosMes(valor);

                                            return GetBuilder<
                                                    FinanceiroController>(
                                                builder: (_) {
                                              return Text(
                                                'R\$ ' +
                                                    financeiroController
                                                        .gastos_mes
                                                        .toPrecision(2)
                                                        .toString()
                                                        .replaceAll(".", ',')
                                                ,
                                                style: GoogleFonts.quicksand(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                            });
                                          } else {
                                            return Container(
                                              height: 40,
                                              width: 40,
                                              alignment: Alignment.center,
                                              child: MyCircularProgressBranco(),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    FontAwesomeIcons.arrowDown,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
              SizedBox(height: 32),
              TituloSessao(titulo: "RECEBIDOS"),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Container(
                  width: widthScreen,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      FutureBuilder<QuerySnapshot>(
                        future: trazerRecebidos(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            financeiroController.atualizarDocumentsRecebidos(
                                List.from(snapshot.data!.docs.reversed));

                            return GetBuilder<FinanceiroController>(
                              builder: (_) {
                                if (financeiroController
                                        .documentsRecebidos.length >=
                                    5) {
                                  return ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    itemCount: 5,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          itemRecebidos(
                                              financeiroController
                                                      .documentsRecebidos[index]
                                                  ['valor'],
                                              financeiroController
                                                      .documentsRecebidos[index]
                                                  ['descricao']),
                                          SizedBox(height: 4),
                                          index != 4
                                              ? linhaDivisoria()
                                              : Container(),
                                          index != 4
                                              ? SizedBox(height: 4)
                                              : Container(),
                                        ],
                                      );
                                    },
                                  );
                                } else if (financeiroController
                                        .documentsRecebidos.length >
                                    0) {
                                  return ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    itemCount: financeiroController
                                        .documentsRecebidos.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          itemRecebidos(
                                              financeiroController
                                                      .documentsRecebidos[index]
                                                  ['valor'],
                                              financeiroController
                                                      .documentsRecebidos[index]
                                                  ['descricao']),
                                          SizedBox(height: 4),
                                          index !=
                                                  financeiroController
                                                          .documentsRecebidos
                                                          .length -
                                                      1
                                              ? linhaDivisoria()
                                              : Container(),
                                          index !=
                                                  financeiroController
                                                          .documentsRecebidos
                                                          .length -
                                                      1
                                              ? SizedBox(height: 4)
                                              : Container()
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 32, left: 8, top: 32),
                                    child: Column(
                                      children: [
                                        Icon(FontAwesomeIcons.exclamation, size: 48, color: cor_do_app),
                                        SizedBox(height: 8),
                                        Text('Nada foi encontrado.', style: GoogleFonts.quicksand(color: cor_do_app, fontSize: 18),),
                                      ],
                                    ),
                                  );
                                }
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
                      ),
                      GetBuilder<FinanceiroController>(builder: (_) {
                        return financeiroController.documentsRecebidos.length > 0 ? InkWell(
                          onTap: () {
                            Get.to(() => MaisFinanceiro(
                                tipoTela: 1,
                                documents:
                                financeiroController.documentsRecebidos));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: widthScreen,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  'DETALHES'.toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1),
                                ),
                              ),
                            ),
                          ),
                        ) : Container();
                      })
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              TituloSessao(titulo: "Gastos"),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Container(
                  width: widthScreen - 16,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      FutureBuilder<QuerySnapshot>(
                        future: trazerGastos(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            financeiroController.atualizarDocumentsGastos(
                                List.from(snapshot.data!.docs.reversed));

                            return GetBuilder<FinanceiroController>(
                                builder: (_) {
                              if (financeiroController.documentsGastos.length >=
                                  5) {
                                return ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        itemGastos(
                                            financeiroController
                                                    .documentsGastos[index]
                                                ['valor'],
                                            financeiroController
                                                    .documentsGastos[index]
                                                ['descricao']),
                                        SizedBox(height: 4),
                                        index != 4
                                            ? linhaDivisoria()
                                            : Container(),
                                        index != 4
                                            ? SizedBox(height: 4)
                                            : Container()
                                      ],
                                    );
                                  },
                                );
                              } else if (financeiroController
                                      .documentsGastos.length >
                                  0) {
                                return ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  itemCount: financeiroController
                                      .documentsGastos.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        itemGastos(
                                            financeiroController
                                                    .documentsGastos[index]
                                                ['valor'],
                                            financeiroController
                                                    .documentsGastos[index]
                                                ['descricao']),
                                        SizedBox(height: 4),
                                        index !=
                                                financeiroController
                                                        .documentsGastos
                                                        .length -
                                                    1
                                            ? linhaDivisoria()
                                            : Container(),
                                        index !=
                                                financeiroController
                                                        .documentsGastos
                                                        .length -
                                                    1
                                            ? SizedBox(height: 4)
                                            : Container()
                                      ],
                                    );
                                  },
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 32, left: 8, top: 32),
                                  child: Column(
                                    children: [
                                      Icon(FontAwesomeIcons.exclamation, size: 48, color: cor_do_app),
                                      SizedBox(height: 8),
                                      Text('Nada foi encontrado.', style: GoogleFonts.quicksand(color: cor_do_app, fontSize: 18),),
                                    ],
                                  ),
                                );
                              }
                            });
                          } else {
                            return Container(
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              child: MyCircularProgress(),
                            );
                          }
                        },
                      ),
                      GetBuilder<FinanceiroController>(builder: (_) {
                        return financeiroController.documentsGastos.length > 0 ? InkWell(
                          onTap: () {
                            Get.to(() => MaisFinanceiro(
                                tipoTela: 2,
                                documents: financeiroController.documentsGastos));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: widthScreen,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  'DETALHES'.toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1),
                                ),
                              ),
                            ),
                          ),
                        ) : Container();
                      }),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              TituloSessao(
                titulo: "CAIXA POR FONTE FINANCEIRA",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Container(
                  width: widthScreen - 16,
                  color: Colors.white,
                  child: GetBuilder<FinanceiroController>(
                    builder: (_) {
                      Map<String, double> dicionario_recebidos = {};
                      Map<String, double> dicionario_gastos = {};
                      Map<String, double> dicionario_resultado = {};

                      for (int i = 0;
                          i < financeiroController.documentsRecebidos.length;
                          i++) {
                        if (dicionario_recebidos.containsKey(
                            financeiroController.documentsRecebidos[i]
                                ['fonte'])) {
                          dicionario_recebidos[financeiroController
                                  .documentsRecebidos[i]['fonte']] =
                              (dicionario_recebidos[financeiroController
                                      .documentsRecebidos[i]['fonte']]! +
                                  financeiroController.documentsRecebidos[i]
                                      ['valor']);
                        } else {
                          dicionario_recebidos[financeiroController
                                  .documentsRecebidos[i]['fonte']] =
                              financeiroController.documentsRecebidos[i]
                                  ['valor'];
                        }
                      }

                      for (int i = 0;
                          i < financeiroController.documentsGastos.length;
                          i++) {
                        if (dicionario_gastos.containsKey(
                            financeiroController.documentsGastos[i]['fonte'])) {
                          dicionario_gastos[financeiroController
                                  .documentsGastos[i]
                              ['fonte']] = (dicionario_gastos[
                                  financeiroController.documentsGastos[i]
                                      ['fonte']]! +
                              financeiroController.documentsGastos[i]['valor']);
                        } else {
                          dicionario_gastos[financeiroController
                                  .documentsGastos[i]['fonte']] =
                              financeiroController.documentsGastos[i]['valor'];
                        }
                      }

                      dicionario_recebidos.forEach((key, value) {
                        if (dicionario_gastos.containsKey(key)) {
                          dicionario_resultado[key] =
                              dicionario_recebidos[key]! -
                                  dicionario_gastos[key]!;
                        } else {
                          dicionario_resultado[key] =
                              dicionario_recebidos[key]!;
                        }
                      });

                      dicionario_gastos.forEach((key, value) {
                        if (!dicionario_recebidos.containsKey(key)) {
                          dicionario_resultado[key] =
                              dicionario_gastos[key]! * -1;
                        }
                      });

                      return FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('atleticas')
                            .doc(globals.atletica_firebase)
                            .collection('financeiro')
                            .doc('fontes')
                            .collection('dados')
                            .where('ativa', isEqualTo: true)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              List<QueryDocumentSnapshot> fontes =
                                  snapshot.data!.docs;

                              if (fontes.length == 0) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 32, left: 8, top: 32),
                                  child: Column(
                                    children: [
                                      Icon(FontAwesomeIcons.exclamation, size: 48, color: cor_do_app),
                                      SizedBox(height: 8),
                                      Text('Não existem fontes ativas.', style: GoogleFonts.quicksand(color: cor_do_app, fontSize: 18),),
                                    ],
                                  ),
                                );
                              } else {
                                return Column(
                                  children:
                                  List.generate(fontes.length, (int index) {
                                    // valor = dicionario_resultado[fontes[index].id]
                                    // titulo = fontes[index]['descricao']

                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: itemFonte(
                                              dicionario_resultado[
                                              fontes[index].id] ==
                                                  null
                                                  ? '0,0'
                                                  : dicionario_resultado[
                                              fontes[index].id],
                                              fontes[index]['descricao']),
                                        ),
                                        index != fontes.length - 1
                                            ? linhaDivisoria()
                                            : Container(),
                                      ],
                                    );
                                  }),
                                );
                              }

                            } else {
                              return Text('erro na hora de trazer as fontes');
                            }
                          } else {
                            return Container(
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              child: MyCircularProgressBranco(),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
      Positioned(
        right: 8,
        bottom: 8,
        child: GestureDetector(
          onTap: () {
            Get.dialog(OpcoesFinanceiro());
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: cor_do_app,
              borderRadius: BorderRadius.circular(300),
            ),
            child: Icon(
              FontAwesomeIcons.ellipsisV,
              color: Colors.white,
            ),
          ),
        ),
      )
    ]);
  }

  Row itemGastos(double valor, String titulo) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Container(
            width: 100,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.red[100],
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Text('R\$ ' + valor.toString().replaceAll(".", ','),
                style:
                    GoogleFonts.montserrat(fontSize: 16, color: Colors.black)),
          ),
        ),
        SizedBox(width: 4),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Container(
              child: Text(titulo, style: GoogleFonts.montserrat()),
            ),
          ),
        )
      ],
    );
  }

  Row itemRecebidos(double valor, String titulo) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Container(
            width: 100,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Text('R\$ ' + valor.toString().replaceAll(".", ','),
                style:
                    GoogleFonts.montserrat(fontSize: 16, color: Colors.black)),
          ),
        ),
        SizedBox(width: 4),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Container(
              child: Text(titulo, style: GoogleFonts.montserrat()),
            ),
          ),
        )
      ],
    );
  }

  Row itemFonte(dynamic valor, String titulo) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Container(
            width: 100,
            decoration: BoxDecoration(
              color: cor_do_app,
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'R\$ ' + valor.toString().replaceAll(".", ','),
                style:
                    GoogleFonts.montserrat(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(width: 4),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Container(
              child: Text(titulo, style: GoogleFonts.montserrat()),
            ),
          ),
        )
      ],
    );
  }

  Padding linhaDivisoria() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }

  String retornaMesAtual() {
    String mesAtual = DateTime.now().toString().substring(5, 7);

    switch (mesAtual) {
      case "01":
        return "Janeiro";
      case "02":
        return "Fevereiro";
      case "03":
        return "Março";
      case "04":
        return "Abril";
      case "05":
        return "Maio";
      case "06":
        return "Junho";
      case "07":
        return "Julho";
      case "08":
        return "Agosto";
      case "09":
        return "Setembro";
      case "10":
        return "Outubro";
      case "11":
        return "Novembro";
      case "12":
        return "Dezembro";
    }

    return "erro";
  }
}
