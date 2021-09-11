import 'package:atletica_online/components/colors.dart';
import 'package:atletica_online/components/dialogs/aviso.dart';
import 'package:atletica_online/components/myAppBar.dart';
import 'package:atletica_online/components/tituloSessao.dart';
import 'package:atletica_online/controllers/financeiro/financeiroController.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'graficosFinanceiro.dart';
import '../../controllers/financeiro/transacaoController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atletica_online/globals.dart' as globals;

class RegistrarTransacao extends StatelessWidget {
  final FinanceiroController financeiroController = Get.find();

  final TransacaoController transacaoController =
      Get.put(TransacaoController());
  final TextEditingController valor = TextEditingController();
  final TextEditingController descricao = TextEditingController();

  Future<QuerySnapshot> trazerFontes() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('atleticas')
        .doc(globals.atletica_firebase)
        .collection('financeiro')
        .doc('fontes')
        .collection('dados')
        .where('ativa', isEqualTo: true)
        .get();
    return querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var safeArea = MediaQuery.of(context).padding.top;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyAppBar(title: 'REGISTRAR TRANSAÇÃO', back: true),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Text(
                      'R\$ ',
                      style: GoogleFonts.quicksand(
                          fontSize: 50, color: azul_principal),
                    ),
                    Flexible(
                      child: TextField(
                          controller: valor,
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.quicksand(
                              fontSize: 50, color: azul_principal),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '00,00',
                              hintStyle: GoogleFonts.quicksand(
                                  fontSize: 50, color: azul_secundario))),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              TituloSessao(titulo: 'Tipo'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<TransacaoController>(
                      builder: (_) {
                        if (transacaoController.tipo == 1) {
                          return InkWell(
                            onTap: () {
                              transacaoController.atualizarTipo(1);
                            },
                            child: Container(
                              height: 50,
                              color: Colors.green[400],
                              width: widthScreen / 2 - 12,
                              child: Center(
                                child: Text(
                                  'RECEBIDO'.toUpperCase(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return InkWell(
                            onTap: () {
                              transacaoController.atualizarTipo(1);
                            },
                            child: Container(
                              height: 50,
                              color: Colors.green[100],
                              width: widthScreen / 2 - 12,
                              child: Center(
                                child: Text(
                                  'RECEBIDO'.toUpperCase(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    GetBuilder<TransacaoController>(
                      builder: (_) {
                        if (transacaoController.tipo == 2) {
                          return InkWell(
                            onTap: () {
                              transacaoController.atualizarTipo(2);
                            },
                            child: Container(
                              height: 50,
                              color: Colors.red[400],
                              width: widthScreen / 2 - 12,
                              child: Center(
                                child: Text(
                                  'DESPESA'.toUpperCase(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return InkWell(
                            onTap: () {
                              transacaoController.atualizarTipo(2);
                            },
                            child: Container(
                              height: 50,
                              color: Colors.red[100],
                              width: widthScreen / 2 - 12,
                              child: Center(
                                child: Text(
                                  'DESPESA'.toUpperCase(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              TituloSessao(titulo: 'Descrição'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: expandTextField(descricao),
              ),
              SizedBox(height: 16),
              TituloSessao(titulo: 'Fonte'),
              SizedBox(height: 4),
              Container(
                width: widthScreen,
                child: FutureBuilder<QuerySnapshot>(
                  future: trazerFontes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<QueryDocumentSnapshot> documents =
                          snapshot.data!.docs;
                      return documents.length > 0
                          ? Wrap(
                              children: List<Widget>.generate(documents.length,
                                  (int index) {
                                return GestureDetector(
                                  onTap: () {
                                    transacaoController.atualizarFonte(
                                        documents[index].reference.id);
                                  },
                                  child: GetBuilder<TransacaoController>(
                                    builder: (_) {
                                      if (transacaoController.fonte ==
                                          documents[index].reference.id) {
                                        return itemFonteSelecionado(
                                            documents[index]
                                                .data()['descricao']);
                                      } else {
                                        return itemFonte(documents[index]
                                            .data()['descricao']);
                                      }
                                    },
                                  ),
                                );
                              }),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8, left: 8, top: 8),
                              child: Column(
                                children: [
                                  Icon(FontAwesomeIcons.exclamation,
                                      size: 48, color: azul_principal),
                                  SizedBox(height: 8),
                                  Text(
                                    'Adicione uma fonte financeira ativa para prosseguir!',
                                    style: GoogleFonts.quicksand(
                                      color: azul_principal,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        child: Text('Aguarde'),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                        () => Container(
                              height: heightScreen,
                              width: widthScreen,
                              color: Colors.white,
                            ),
                        transition: Transition.rightToLeft);
                  },
                  child: InkWell(
                    onTap: () async {
                      bool internet =
                          await DataConnectionChecker().hasConnection;

                      if (valor.text.isNotEmpty &&
                          transacaoController.tipo != 0 &&
                          descricao.text.isNotEmpty &&
                          transacaoController.fonte != '') {
                        if (internet == true) {
                          if (transacaoController.tipo == 1) {
                            var mesAtual =
                                DateTime.now().toString().substring(5, 7);
                            var anoAtual =
                                DateTime.now().toString().substring(0, 4);
                            Map<String, dynamic> dadosApp = {
                              "valor":
                                  double.parse(valor.text.replaceAll(',', '.')),
                              "descricao": descricao.text,
                              "fonte": transacaoController.fonte,
                              "mes": mesAtual,
                              "ano": anoAtual
                            };

                            CollectionReference collectionReference =
                                FirebaseFirestore.instance
                                    .collection('atleticas')
                                    .doc(globals.atletica_firebase)
                                    .collection('financeiro')
                                    .doc('recebidos')
                                    .collection('dados');
                            collectionReference
                                .doc(DateTime.now().toString())
                                .set(dadosApp);
                            DocumentReference documentReference =
                                FirebaseFirestore.instance
                                    .collection('atleticas')
                                    .doc(globals.atletica_firebase)
                                    .collection('financeiro')
                                    .doc('caixa');
                            documentReference.get().then((value) {
                              double valorAdd = double.parse(value['valor']) +
                                  double.parse(valor.text.replaceAll(',', '.'));
                              Map<String, dynamic> dadosUpdate = {
                                "valor": valorAdd.toString(),
                              };
                              documentReference.update(dadosUpdate);
                            });

                            await Get.dialog(Aviso(
                                titulo: 'Transação armazenada com sucesso!',
                                subTitulo: '',
                                color: Colors.green));
                            Get.back();
                          }

                          if (transacaoController.tipo == 2) {
                            var mesAtual =
                                DateTime.now().toString().substring(5, 7);
                            var anoAtual =
                                DateTime.now().toString().substring(0, 4);

                            Map<String, dynamic> dadosApp = {
                              "valor":
                                  double.parse(valor.text.replaceAll(',', '.')),
                              "descricao": descricao.text,
                              "fonte": transacaoController.fonte,
                              "mes": mesAtual,
                              "ano": anoAtual,
                            };

                            CollectionReference collectionReference =
                                FirebaseFirestore.instance
                                    .collection('atleticas')
                                    .doc(globals.atletica_firebase)
                                    .collection('financeiro')
                                    .doc('gastos')
                                    .collection('dados');
                            collectionReference
                                .doc(DateTime.now().toString())
                                .set(dadosApp);
                            DocumentReference documentReference =
                                FirebaseFirestore.instance
                                    .collection('atleticas')
                                    .doc(globals.atletica_firebase)
                                    .collection('financeiro')
                                    .doc('caixa');
                            documentReference.get().then((value) {
                              double valorSub = double.parse(value['valor']) -
                                  double.parse(valor.text.replaceAll(',', '.'));
                              Map<String, dynamic> dadosUpdate = {
                                "valor": valorSub.toString(),
                              };
                              documentReference.update(dadosUpdate);
                            });

                            await Get.dialog(Aviso(
                                titulo: 'Transação armazenada com sucesso!',
                                subTitulo: '',
                                color: Colors.green));
                            Get.back();
                          }
                        } else {
                          Get.dialog(Aviso(
                              titulo: 'Não há conexão com a Internet',
                              subTitulo:
                                  'Confira a disponibilidade em seu dispositivo.',
                              color: Colors.red));
                        }
                      } else {
                        Get.dialog(Aviso(
                            titulo:
                                'Existem um ou mais campos obrigatórios não preenchidos',
                            subTitulo:
                                'Confira se você colocou o valor, tipo, descrição e a fonte do dinheiro.',
                            color: Colors.red));
                      }
                    },
                    child: Container(
                      height: 50,
                      width: widthScreen - 16,
                      decoration: BoxDecoration(color: azul_principal),
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
              ),
            ],
          ),
        ),
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

  Padding itemFonteSelecionado(String titulo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[400],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            titulo,
            style: GoogleFonts.quicksand(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Padding title(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.quicksand(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[700]),
      ),
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
            cursorColor: azul_principal,
            style: GoogleFonts.quicksand(fontSize: 16),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Padding expandTextField(TextEditingController tController) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 16),
      child: Container(
        color: Colors.grey[200],
        height: 100,
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            controller: tController,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
            maxLines: null,
            minLines: null,
            expands: true,
            cursorColor: azul_principal,
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
