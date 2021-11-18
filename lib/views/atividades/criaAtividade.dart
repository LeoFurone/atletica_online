import 'package:atletica_online/components/colors.dart';
import 'package:atletica_online/components/dialogs/adicionaSubTask.dart';
import 'package:atletica_online/components/dialogs/aviso.dart';
import 'package:atletica_online/components/myAppBar.dart';
import 'package:atletica_online/components/myCircularProgress.dart';
import 'package:atletica_online/controllers/atividades/atividadeController.dart';
import 'package:atletica_online/controllers/atividades/criaAtividadeController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atletica_online/globals.dart' as globals;

class CriaAtividade extends StatelessWidget {


  Future<QuerySnapshot> trazerTags() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('atleticas')
        .doc(globals.atletica_firebase)
        .collection('tags_atividades')
        .get();
    return querySnapshot;
  }

  Future<QuerySnapshot> trazerUsuarios() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('mapeamento').where("atletica", isEqualTo: globals.atletica_firebase).get();
    return querySnapshot;
  }

  final CriaAtividadeController criaAtividadeController = Get.put(CriaAtividadeController());
  final AtividadeController atividadeController = Get.find();
  final TextEditingController titulo = TextEditingController();
  final TextEditingController descricao = TextEditingController();



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
              MyAppBar(
                title: 'nova atividade',
                back: true,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, right: 8, bottom: 4, top: 16),
                child: Text(
                  'Título da atividade',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: cor_do_app),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 4, bottom: 16, left: 8, right: 8),
                child: Container(
                  color: Colors.grey[200],
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: titulo,
                      textCapitalization: TextCapitalization.sentences,
                      cursorColor: cor_do_app,
                      style: GoogleFonts.quicksand(fontSize: 16),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, right: 8, bottom: 4, top: 16),
                child: Text(
                  'Descrição da atividade',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: cor_do_app),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 4, bottom: 16, left: 8, right: 8),
                child: Container(
                  color: Colors.grey[200],
                  height: 100,
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: descricao,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: null,
                      minLines: null,
                      expands: true,
                      cursorColor: cor_do_app,
                      style: GoogleFonts.quicksand(fontSize: 16),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              IntrinsicWidth(
                child: Column(
                  children: [
                    Container(
                      width: (widthScreen - 16) / 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 4, top: 16),
                        child: Text(
                          'Prazo de conclusão',
                          style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: cor_do_app),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 4, bottom: 16, left: 8, right: 8),
                      child: InkWell(
                        child: GetBuilder<CriaAtividadeController>(
                          builder: (_) {
                            return falseTextField(
                                gerarDataString(criaAtividadeController.data));
                          },
                        ),
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }

                          showDatePicker(
                              context: context,
                              initialDate: criaAtividadeController.data,
                              firstDate: DateTime(1970),
                              lastDate: DateTime(3000),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.dark().copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: cor_do_app,
                                      onPrimary: Colors.white,
                                      surface: cor_do_app,
                                      onSurface: cor_do_app,
                                    ),
                                    dialogBackgroundColor: Colors.white,
                                  ),
                                  child: child!,
                                );
                              }).then((date) {
                            if (date != null) {
                              criaAtividadeController.atualizaData(date);
                            }
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, right: 8, bottom: 4, top: 16),
                child: Text(
                  'Sub-Tarefas',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: cor_do_app),
                ),
              ),
              GetBuilder<CriaAtividadeController>(
                builder: (_) {
                  return criaAtividadeController.subtasks.length <= 0
                      ? Center(
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
                        )
                      : Column(
                          children: List.generate(
                              criaAtividadeController.subtasks.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 6),
                              child: Container(
                                color: Colors.grey[200],
                                width: widthScreen - 16,
                                child: Row(
                                  children: [
                                    Checkbox(
                                        activeColor: cor_do_app,
                                        value: criaAtividadeController.subtasks[index][criaAtividadeController.subtasks[index].keys.first],
                                        onChanged: (bool? value) {
                                          criaAtividadeController.atualizarCheckboxSubtask(index, value);
                                        }),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          criaAtividadeController.subtasks[index].keys.first,
//                              widget.atividade['subtasks'][index].keys.first,
                                          style: GoogleFonts.quicksand(
                                              fontSize: 18,
                                              color: Colors.black87),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        criaAtividadeController.removeSubtask(index);
                                      },
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Icon(FontAwesomeIcons.trash,
                                              color: Colors.black, size: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                },
              ),
              SizedBox(height: 8),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    String tituloSubTask = await Get.dialog(AdicionaSubTask());

                    if (tituloSubTask != null) {
                      criaAtividadeController
                          .adicionaSubtask({tituloSubTask: false});
                    }
                  },
                  child: Container(
                    height: 40,
                    width: widthScreen - 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: cor_do_app, width: 3)),
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

              Padding(
                padding: const EdgeInsets.only(
                    left: 8, right: 8, bottom: 4, top: 24),
                child: Text(
                  'Tag',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: cor_do_app),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<QuerySnapshot>(
                    future: trazerTags(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        atividadeController.atualizaTags(
                            List.from(snapshot.data!.docs));
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
                                      criaAtividadeController.atualizaTag(atividadeController.tags[atividadeController.tags.length - index -1]['titulo']);
                                    },
                                    child: GetBuilder<CriaAtividadeController>(
                                      builder: (_) {
                                        if(criaAtividadeController.tag != atividadeController.tags[atividadeController.tags.length - index -1]['titulo']) {
                                          return Container(
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
                                          );
                                        } else {
                                          return Container(
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
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ) ,
                                  );
                                }),
                              ),
                            )
                                : Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8, left: 8, top: 8),
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
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, right: 8, bottom: 4, top: 16),
                child: Text(
                  '* Você será o responsável por essa atividade',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.red),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () async {

                    if (
                    titulo.text != "" &&
                    descricao.text != ""
                    ) {



                      Map<String, dynamic> dados = {
                        "tipo": 'atv',
                        "concluida": false,
                        "descricao": descricao.text,
                        "prazo": gerarDataFirebase(criaAtividadeController.data), // sera que da pau?
                        "responsavel": FirebaseAuth.instance.currentUser!.email!.substring(0,FirebaseAuth.instance.currentUser!.email!.indexOf('@')),
                        "subtasks": criaAtividadeController.subtasks,
                        "tag": criaAtividadeController.tag,
                        "titulo": titulo.text
                      };

                      CollectionReference collectionReference = FirebaseFirestore.instance
                          .collection('atleticas')
                          .doc(globals.atletica_firebase)
                          .collection('atividades');

                      await collectionReference.doc(DateTime.now().toString()).set(dados);
                      Get.back();
                      Get.dialog(Aviso(
                        titulo: "Atividade registrada com sucesso!",
                        subTitulo: "Seus dados foram persistidos no banco de dados",
                        color: Colors.green,
                      ));


                    } else {
                      Get.dialog(Aviso(
                        titulo: "Existem campos obrigatórios não preenchidos!",
                        subTitulo: "Campos obrigatórios: título e descrição.",
                        color: Colors.red,
                      ));
                    }


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
                        'CRIAR ATIVIDADE',
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
              SizedBox(height: 16),


            ],
          ),
        ),
      ),
    );
  }

  String gerarDataString(DateTime date) {
    return acertaData(date.day.toString()) +
        '/' +
        acertaData(date.month.toString()) +
        '/' +
        date.year.toString();
  }

  String gerarDataFirebase(DateTime date) {
    return date.year.toString() +
        '/' +
        acertaData(date.month.toString()) +
        '/' +
    acertaData(date.day.toString());
  }

  String acertaData(String valor) => valor.length != 2 ? '0' + valor : valor;

  Container falseTextField(String text, {double height = 50}) {
    return Container(
      color: Colors.grey[300],
      height: height,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          text,
          style: GoogleFonts.quicksand(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }
}
