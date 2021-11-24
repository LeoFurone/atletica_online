import 'dart:convert';

import 'package:atletica_online/components/colors.dart';
import 'package:atletica_online/components/dialogs/aviso.dart';
import 'package:atletica_online/components/myCircularProgress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class MaisInfoLogin extends StatelessWidget {
  final TextEditingController nome = TextEditingController();
  final TextEditingController responsavel = TextEditingController();

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
              Container(
                height: safeArea,
                color: cor_do_app,
              ),
              Container(
                color: cor_do_app,
                width: widthScreen,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back_ios, size: 32, color: Colors.white),
                        Text(
                          'VOLTAR'.toUpperCase(),
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
              ),
              SizedBox(height: 16),
              titulo('nome da atlética'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 80),
                  child: myTextField(nome),
                ),
              ),
              SizedBox(height: 16),
              titulo('e-mail do responsável'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 40),
                  child: myTextField(responsavel),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Center(
                child: InkWell(
                  onTap: () async {

                    if(responsavel.text.contains('@') && nome.text != "") {

                      Get.dialog(
                          MaterialApp(
                            home: Scaffold(
                              backgroundColor: Colors.transparent,
                              body: Container(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: MyCircularProgress(),
                                  ),
                                ),
                              ),
                            ),
                            debugShowCheckedModeBanner: false,
                          )
                      );
                      dynamic response = await enviarEmail();

                      if(response.statusCode == 200) {
                        Get.back();
                        Get.dialog(
                            Aviso(
                              titulo: 'Solicitação enviada com sucesso!',
                              subTitulo: 'Aguarde que em breve entraremos em contato com você.',
                              color: Colors.green,

                            ));
                      } else {
                        Get.back();
                        Get.dialog(
                            Aviso(
                              titulo: 'Erro ao enviar solicitação',
                              subTitulo: 'Tente novamente.',
                              color: Colors.red,
                            ));
                      }

                    } else {
                      Get.dialog(Aviso(titulo: 'Seus dados foram preenchidos de maneira incorreta', subTitulo: 'Confira novamente e veja qual é o problema.', color: Colors.red));
                    }
                  },
                  child: Container(
                    width: widthScreen - 16,
                    height: 50,
                    decoration: BoxDecoration(
                      color: cor_do_app,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'ENVIAR SOLICITAÇÃO',
                      style: GoogleFonts.quicksand(
                          color: Colors.white,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
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

  Padding titulo(String titulo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        titulo.toUpperCase(),
        style: GoogleFonts.quicksand(
          color: cor_do_app,
          letterSpacing: 2,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  TextField myTextField(TextEditingController tcontroller,
      {bool senha = false, bool icon = false}) {
    return TextField(
      controller: tcontroller,
      obscureText: senha,
      expands: true,
      maxLines: null,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10),
            ),
            borderSide: BorderSide(color: Colors.grey, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10),
            ),
            borderSide: BorderSide(color: cor_do_app, width: 2)),
      ),
    );
  }

  Future enviarEmail() async {

    final serviceId = 'service_9ezzjkq';
    final templateId = 'template_qnnrqb9';
    final userId = 'user_2cOKhK4ojJk1le5DyTli6';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'nome_atletica': nome.text,
          'email_responsavel': responsavel.text,
        }
      }),
    );


    return response;

  }
}
