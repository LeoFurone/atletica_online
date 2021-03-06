import 'package:atletica_online/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PerguntasFrequentes extends StatelessWidget {
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
            Container(
              height: safeArea,
              color: cor_do_app,
            ),
            Container(
              color: cor_do_app,
              width: widthScreen,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 50,
                        child: Icon(Icons.arrow_back_ios,
                            size: 32, color: Colors.white),
                      ),
                    ),
                    Text(
                      'PERGUNTAS FREQUENTES'.toUpperCase(),
                      style: GoogleFonts.quicksand(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Container(
                width: widthScreen - 16,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textoNegrito('Como fa??o para adicionar a minha Atl??tica no app?'),
                      textoNormal('Volta na tela anterior e clique no bot??o "Solicitar Inclus??o de Atl??tica". Preencha os dados e aguarde at?? receber uma resposta via e-mail. '),
                      SizedBox(height: 32),
                      textoNegrito('Como fa??o para adicionar mais membros em minha Atl??tica?'),
                      textoNormal('O respons??vel pela atl??tica deve solicitar mais licen??as para o desenvolvedor.'),
                      SizedBox(height: 32),
                      textoNegrito('O aplicativo tem algum custo?'),
                      textoNormal('N??o! ?? gratuito e sempre ser??!'),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text textoNegrito(String txt) {
    return Text(
                    txt,
                    style: GoogleFonts.quicksand(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
  }

  Text textoNormal(String txt) {
    return Text(
      txt,
      style: GoogleFonts.quicksand(
        fontSize: 18,
      ),
    );
  }
}
