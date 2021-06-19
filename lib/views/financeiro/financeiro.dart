import 'package:atletica_online/components/colors.dart';
import 'package:atletica_online/components/dialogs/opcoesFinanceiro.dart';
import 'package:atletica_online/components/myCircularProgress.dart';
import 'package:atletica_online/components/myCircularProgressBranco.dart';
import 'package:atletica_online/components/tituloSessao.dart';
import 'package:atletica_online/graficosFinanceiro.dart';
import 'package:atletica_online/views/financeiro/maisFinanceiro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Financeiro extends StatelessWidget {

  final double heightScreen;
  final double widthScreen;
  final double safeArea;

  const Financeiro(
      {Key? key,
      required this.heightScreen,
      required this.widthScreen,
      required this.safeArea})
      : super(key: key);

  Future<DocumentSnapshot> trazerValorCaixa() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('financeiro')
        .doc('caixa')
        .get();
    return documentSnapshot;
  }

  Future<QuerySnapshot> trazerGastos() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('financeiro')
        .doc('gastos')
        .collection('dados')
        .get();
    return querySnapshot;
  }

  Future<QuerySnapshot> trazerRecebidos() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
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
    List<QueryDocumentSnapshot> documentsGastos = [];
    List<QueryDocumentSnapshot> documentsRecebidos = [];
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
              Container(height: safeArea, color: azul_principal),
              Container(
                width: widthScreen,
                decoration: BoxDecoration(
                    color: azul_principal,
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

                          if (snapshot.data!['valor'].runtimeType == double) {
                            double value = snapshot.data!['valor'];
                            return Text(
                              'R\$ ' + value.toPrecision(2).toString(),
                              style: GoogleFonts.montserrat(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            );
                          }

                          if (snapshot.data!['valor'].runtimeType == int) {
                            int value = snapshot.data!['valor'];
                            return Text(
                              'R\$ ' + value.toString(),
                              style: GoogleFonts.montserrat(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            );
                          }

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

                                            return Text(
                                              'R\$ ' + valor.toPrecision(2).toString(),
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
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

                                            return Text(
                                              'R\$ ' + valor.toPrecision(2).toString(),
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
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
                            documentsRecebidos =
                                List.from(snapshot.data!.docs.reversed);

                            if (documentsRecebidos.length >= 5) {
                              return ListView.builder(
                                padding: EdgeInsets.all(0),
                                shrinkWrap: true,
                                itemCount: 5,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      itemRecebidos(
                                          documentsRecebidos[index]['valor'],
                                          documentsRecebidos[index]
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
                            } else if (documentsRecebidos.length > 0) {
                              return ListView.builder(
                                padding: EdgeInsets.all(0),
                                shrinkWrap: true,
                                itemCount: documentsRecebidos.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      itemRecebidos(
                                          documentsRecebidos[index]['valor'],
                                          documentsRecebidos[index]
                                              ['descricao']),
                                      SizedBox(height: 4),
                                      index != documentsRecebidos.length - 1
                                          ? linhaDivisoria()
                                          : Container(),
                                      index != documentsRecebidos.length - 1
                                          ? SizedBox(height: 4)
                                          : Container()
                                    ],
                                  );
                                },
                              );
                            } else {
                              return Text('sem nada');
                            }
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
                      InkWell(
                        onTap: () {
                          Get.to(() => MaisFinanceiro(
                              tipoTela: 1, documents: documentsRecebidos));
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
                      ),
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
                            documentsGastos =
                                List.from(snapshot.data!.docs.reversed);

                            if (documentsGastos.length >= 5) {
                              return ListView.builder(
                                padding: EdgeInsets.all(0),
                                shrinkWrap: true,
                                itemCount: 5,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      SizedBox(height: 4),
                                      itemGastos(
                                          documentsGastos[index]['valor'],
                                          documentsGastos[index]['descricao']),
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
                            } else if (documentsGastos.length > 0) {
                              return ListView.builder(
                                padding: EdgeInsets.all(0),
                                shrinkWrap: true,
                                itemCount: documentsGastos.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      itemGastos(
                                          documentsGastos[index]['valor'],
                                          documentsGastos[index]['descricao']),
                                      SizedBox(height: 4),
                                      index != documentsGastos.length - 1
                                          ? linhaDivisoria()
                                          : Container(),
                                      index != documentsGastos.length - 1
                                          ? SizedBox(height: 4)
                                          : Container()
                                    ],
                                  );
                                },
                              );
                            } else {
                              return Text('sem nada');
                            }
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
                      InkWell(
                        onTap: () {
                          Get.to(() => MaisFinanceiro(
                              tipoTela: 2, documents: documentsGastos));
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
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              TituloSessao(
                titulo: "RELATÓRIO FINANCEIRO",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => GraficosFinanceiro());
                  },
                  child: Container(
                    height: 100,
                    width: widthScreen - 16,
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'CLIQUE PARA VER MAIS',
                        style: GoogleFonts.montserrat(
                          color: azul_principal,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
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
              color: azul_principal,
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
