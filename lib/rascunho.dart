import 'package:atletica_online/components/colors.dart';
import 'package:atletica_online/components/dialogs/opcoesTarefas.dart';
import 'package:atletica_online/components/dialogs/vazio.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Atividades extends StatelessWidget {
  final double heightScreen;
  final double widthScreen;
  final double safeArea;

  const Atividades(
      {Key? key,
        required this.heightScreen,
        required this.widthScreen,
        required this.safeArea})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(DateTime.now());

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
                SizedBox(height: safeArea + 4),
                InkWell(
                  onTap: () {
                    Get.dialog(Vazio());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Administrativo'.toUpperCase(),
                        style: GoogleFonts.raleway(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: cor_do_app),
                      ),
                      Icon(FontAwesomeIcons.angleDown)
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '06/04',
                  style: GoogleFonts.quicksand(),
                ),
                tarefa(
                  'Título da tarefa aqui com teste de overflow e vamo ver se dá isso mesmo',
                  'Descrição da tarefa aqui com o teste colocando muitas palavras para ver qual a aprensetação ao decorrer dessa situação',
                ),
                SizedBox(height: 2),
                tarefa(
                  'Título da tarefa aqui com teste de overflow e vamo ver se dá isso mesmo',
                  'Descrição da tarefa aqui com o teste colocando muitas palavras para ver qual a aprensetação ao decorrer dessa situação',
                ),
                SizedBox(height: 16),
                Text(
                  '07/04',
                  style: GoogleFonts.quicksand(),
                ),
                tarefa(
                  'Título da tarefa aqui com teste de overflow e vamo ver se dá isso mesmo',
                  'Descrição da tarefa aqui com o teste colocando muitas palavras para ver qual a aprensetação ao decorrer dessa situação',
                ),
                SizedBox(height: 2),
                tarefa(
                  'Título da tarefa aqui com teste de overflow e vamo ver se dá isso mesmo',
                  'Descrição da tarefa aqui com o teste colocando muitas palavras para ver qual a aprensetação ao decorrer dessa situação',
                ),
                SizedBox(height: 2),
                tarefa(
                  'Título da tarefa aqui com teste de overflow e vamo ver se dá isso mesmo',
                  'Descrição da tarefa aqui com o teste colocando muitas palavras para ver qual a aprensetação ao decorrer dessa situação',
                ),
                SizedBox(height: 40),


              ],
            ),
          ),
        ),
        Positioned(
          right: 8,
          bottom: 8,
          child: GestureDetector(
            onTap: ( ) {
              Get.dialog(OpcoesTarefas());
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: cor_do_app,
                borderRadius: BorderRadius.circular(300),
              ),
              child: Icon(FontAwesomeIcons.ellipsisV, color: Colors.white,),
            ),
          ),
        )
      ],
    );
  }

  Container tarefa(String titulo, String descricao) {
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
                  padding: const EdgeInsets.only(
                      top: 8, left: 8, right: 8),
                  child: Text(
                    titulo,
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    descricao,
                    style: GoogleFonts.quicksand(fontSize: 12),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          SizedBox(
            width: 110,
            height: 40,
            child: Stack(
              children: [
                Positioned(
                  right: 8,
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(300),
                      child: Container(
                        height: 40,
                        child: Image.asset(
                            'assets/images/appeu.jpg'),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 38,
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(300),
                      child: Container(
                        height: 40,
                        child: Image.asset(
                            'assets/images/appeu.jpg'),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 68,
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: vermelho_secundario,
                      borderRadius: BorderRadius.circular(300),
                    ),
                    child: Text('+3', style: GoogleFonts.quicksand(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
