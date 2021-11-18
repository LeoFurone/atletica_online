import 'package:atletica_online/components/colors.dart';
import 'package:atletica_online/components/myAppBar.dart';
import 'package:atletica_online/components/myCircularProgress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atletica_online/globals.dart' as globals;

class MaisFinanceiro extends StatelessWidget {
  final int tipoTela;
  final List<dynamic> documents;

  const MaisFinanceiro(
      {Key? key, required this.tipoTela, required this.documents})
      : super(key: key);

  Future<QuerySnapshot> trazerFontes() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('atleticas')
        .doc(globals.atletica_firebase)
        .collection('financeiro')
        .doc('fontes')
        .collection('dados')
        .get();
    return querySnapshot;
  }

  String trazerNomeFonte(String id, List<QueryDocumentSnapshot> lista_fontes) {
    for(int i =0 ; i < lista_fontes.length ; i++){
      if (lista_fontes[i].id == id) {
        return lista_fontes[i]['descricao'];
      }
    }

    return 'erro: fonte não escontrada!';

  }

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var safeArea = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Column(
        children: [
          MyAppBar(
            title: tipoTela == 1 ? 'Todos os recebidos' : 'Todos os Gastos',
            back: true,
          ),
          FutureBuilder<QuerySnapshot>(
            future: trazerFontes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {

                QuerySnapshot? querySnapshot = snapshot.data;
                List<QueryDocumentSnapshot> lista_fontes = querySnapshot!.docs;


                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 5),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
//                          height: 110,
                          width: widthScreen,
                          color: Colors.grey[200],
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 30,
                                  child: Container(
                                    color: tipoTela == 1
                                        ? Colors.green[300]
                                        : Colors.red[300],
                                    alignment: Alignment.center,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Text(
                                          'R\$ ' +
                                              documents[index]['valor']
                                                  .toString()
                                                  .replaceAll(".", ','),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.quicksand(
                                              fontSize: 24, color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 70,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          documents[index]['descricao']
                                              .toString(),
                                          style: GoogleFonts.quicksand(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(FontAwesomeIcons.wallet,
                                                size: 20),
                                            SizedBox(width: 4),
                                            Text(
                                              trazerNomeFonte(documents[index]['fonte'].toString(), lista_fontes),
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(FontAwesomeIcons.clock,
                                                size: 20),
                                            SizedBox(width: 4),
                                            Text(
                                              documents[index]
                                                      .id
                                                      .substring(8, 10) +
                                                  '/' +
                                                  documents[index]
                                                      .id
                                                      .substring(5, 7) +
                                                  '/' +
                                                  documents[index]
                                                      .id
                                                      .substring(0, 4) +
                                                  ' - ' +
                                                  documents[index]
                                                      .id
                                                      .substring(11, 16),
//                                      '03/05/2021 - 14:53'  ,
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(FontAwesomeIcons.user,
                                                size: 20),
                                            SizedBox(width: 4),
                                            Text(
                                              documents[index]['responsavel'],
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: MyCircularProgress(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
