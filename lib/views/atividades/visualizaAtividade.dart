import 'package:atletica_online/components/colors.dart';
import 'package:atletica_online/components/dialogs/adicionaSubTask.dart';
import 'package:atletica_online/components/dialogs/aviso.dart';
import 'package:atletica_online/components/dialogs/confirmacao.dart';
import 'package:atletica_online/components/myAppBar.dart';
import 'package:atletica_online/controllers/atividades/atividadeController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atletica_online/globals.dart' as globals;

class VisualizaAtividade extends StatefulWidget {

  final dynamic atividade;

  VisualizaAtividade({Key? key, required this.atividade}) : super(key: key);

  @override
  _VisualizaAtividadeState createState() => _VisualizaAtividadeState();
}

class _VisualizaAtividadeState extends State<VisualizaAtividade> {

  List<bool?> booleanSubtasks = [];
  bool? chbox_concluida;
  List<dynamic> subtasks = [];


  @override
  void initState() {
    subtasks = widget.atividade['subtasks'];
    chbox_concluida = widget.atividade['concluida'];

    for(int n = 0 ; n < widget.atividade['subtasks'].length ; n++) {
      booleanSubtasks.add(widget.atividade['subtasks'][n][widget.atividade['subtasks'][n].keys.first]);
    }
  }

  final AtividadeController atividadeController = Get.find();

  @override
  Widget build(BuildContext context) {

    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var safeArea = MediaQuery.of(context).padding.top;


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyAppBar(title: 'detalhes da atividade', back: true,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  widget.atividade['tag'] != '' ? Row(
                    children: [
                      Container(
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            widget.atividade['tag'].toUpperCase(),
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ) : Container(),
                  Container(
                    color: Colors.red[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'PRAZO: ' + arrumar_prazo(widget.atividade['prazo']),
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 16),
              child: Text(
                widget.atividade['titulo'],
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, fontSize: 32, color: cor_do_app),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Text(
                widget.atividade['descricao'],
                style: GoogleFonts.quicksand(
                  fontSize: 18, color: Colors.black87
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Container(
                color: Colors.grey[200],
                width: widthScreen - 16,
                height: 40,
                child: Row(
                  children: [
                    Checkbox(
                        activeColor: cor_do_app,
                        value: chbox_concluida,
                        onChanged: (bool? value) {
                          setState(() {
                            chbox_concluida = value;
                          });
                        },
                    ),
                    Text(
                      'Concluída',
                      style: GoogleFonts.quicksand(
                          fontSize: 18, color: Colors.black87
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 16),
              child: Text(
                'Responsável',
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, fontSize: 18, color: cor_do_app),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Container(
                color: Colors.grey[200],
                width: widthScreen - 16,
                height: 40,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    widget.atividade['responsavel'],
                    style: GoogleFonts.quicksand(
                        fontSize: 18, color: Colors.black87
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 16),
              child: Text(
                'Sub-Tarefas',
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, fontSize: 18, color: cor_do_app),
              ),
            ),
            subtasks.length <= 0 ? Center(
              child: Container(
                width: widthScreen - 16,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(FontAwesomeIcons.exclamation,
                          size: 60, color: cor_do_app),
                      SizedBox(height: 8),
                      Text(
                        'Nenhuma Sub-Tarefa',
                        style: GoogleFonts.quicksand(
                          color: cor_do_app,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ) : Column(
              children: List.generate(subtasks.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 6),
                  child: Container(
                    color: Colors.grey[200],
                    width: widthScreen - 16,
                    child: Row(
                      children: [
                        Checkbox(
                            activeColor: cor_do_app,
                            value: booleanSubtasks[index], onChanged: (bool? value) {
                          setState(() {
                            booleanSubtasks[index] = value;
                          });
                        }),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              subtasks[index].keys.first,
//                              widget.atividade['subtasks'][index].keys.first,
                              style: GoogleFonts.quicksand(
                                  fontSize: 18, color: Colors.black87
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              subtasks.removeAt(index);
                              booleanSubtasks.removeAt(index);
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(FontAwesomeIcons.trash, color: Colors.black, size: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 8),
            Center(
              child: GestureDetector(
                onTap: () async {
                  String tituloSubTask = await Get.dialog(AdicionaSubTask());

                  if (tituloSubTask != null) {
                    setState(() {
                      subtasks.add({tituloSubTask: false});
                      booleanSubtasks.add(false);
                    });
                  }
                },
                child: Container(
                  height: 40,
                  width: widthScreen - 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: cor_do_app, width: 3)
                  ),
                  child: Center(
                    child: Text(
                      'ADICIONAR SUB-TAREFA',
                      style: GoogleFonts.quicksand(
                          color: cor_do_app,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
            Center(
              child: GestureDetector(
                onTap: () async {

                  for(int n = 0; n < subtasks.length ; n++){
                    subtasks[n][subtasks[n].keys.first] = booleanSubtasks[n];
                  }

                  Map<String,dynamic> dados = {};

                  if (chbox_concluida == true) {
                    dados = {
                      "concluida": chbox_concluida,
                      "descricao": widget.atividade['descricao'],
                      "prazo": widget.atividade['prazo'],
                      "responsavel": widget.atividade['responsavel'],
                      "subtasks": subtasks,
                      "tag": widget.atividade['tag'],
                      "titulo": widget.atividade['titulo'],
                      "hora_conclusao": DateTime.now().toString(),
                    };
                  } else {
                  dados = {
                  "concluida": chbox_concluida,
                  "descricao": widget.atividade['descricao'],
                  "prazo": widget.atividade['prazo'],
                  "responsavel": widget.atividade['responsavel'],
                  "subtasks": subtasks,
                  "tag": widget.atividade['tag'],
                  "titulo": widget.atividade['titulo']
                  };
                  }

                  DocumentReference atualizaFirebase = await FirebaseFirestore.instance
                      .collection('atleticas')
                      .doc(globals.atletica_firebase)
                      .collection('atividades').doc(widget.atividade.id);

                  await atualizaFirebase.update(dados);

                  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                      .collection('atleticas')
                      .doc(globals.atletica_firebase)
                      .collection('atividades')
                      .where("concluida", isEqualTo: false)
                      .get();

                  atividadeController.atualizaAtividades(querySnapshot.docs);
                  await Get.dialog(
                      Aviso(
                        titulo: 'Atualizações Salvas com sucesso!',
                        subTitulo: 'Sua atividade foi atualizada.',
                        color: Colors.green,
                  ));
                  Get.back();
                },
                child: Container(
                  height: 40,
                  width: widthScreen - 16,
                  decoration: BoxDecoration(
                      color: cor_do_app,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'SALVAR MODIFICAÇÕES',
                      style: GoogleFonts.quicksand(
                          color: Colors.white,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  String arrumar_prazo(String data_errada) {
    return data_errada.substring(8,10) + '/' + data_errada.substring(5,7) +'/' + data_errada.substring(0,4);
  }
}
