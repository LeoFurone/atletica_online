import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
                color: Colors.black,
              ),
              Container(
                color: Colors.black,
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
                    print(nome.text + '\n' + responsavel.text);

                    final Email email = Email(
                      body: nome.text + '\n' + responsavel.text,
                      subject: 'Nova solicitação - App Atlética',
                      recipients: ['leonardo.furone@gmail.com'],
                      isHTML: false,
                    );
                    await FlutterEmailSender.send(email);
                  },
                  child: Container(
                    width: widthScreen - 16,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
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
          color: Colors.black,
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
            borderSide: BorderSide(color: Colors.black, width: 2)),
      ),
    );
  }
}
