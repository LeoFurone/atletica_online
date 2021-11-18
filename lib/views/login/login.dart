import 'package:atletica_online/components/colors.dart';
import 'package:atletica_online/controllers/loginController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/dialogs/aviso.dart';
import '../../home.dart';
import 'maisInfoLogin.dart';

class Login extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  final TextEditingController email = TextEditingController();
  final TextEditingController senha = TextEditingController();

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
        body: Container(
          width: widthScreen,
          height: heightScreen,
          decoration: BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: widthScreen,
                  height: safeArea,
                  color: cor_do_app,
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Bem vindo!',
                    style: GoogleFonts.quicksand(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Faça seu login ou solicite a inclusão da sua Associação Atlética.',
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        letterSpacing: 1.5,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'E-MAIL',
                    style: GoogleFonts.quicksand(
                      color: Colors.black,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: textFieldLogin(email),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'SENHA',
                    style: GoogleFonts.quicksand(
                      color: Colors.black,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GetBuilder<LoginController>(
                    builder: (_) {
                      if (loginController.monstrandoSenha == false) {
                        return textFieldLogin(senha, senha: true, icon: true);
                      } else {
                        return textFieldLogin(senha, senha: false, icon: true);
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GetBuilder<LoginController>(
                    builder: (_) {
                      if (loginController.carregando == false) {
                        return InkWell(
                          onTap: () async {
                            try {
                              loginController.atualizarCarregando(true);
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email.text, password: senha.text);
                              //final FirebaseUser user = await FirebaseAuth.instance.currentUser();
                              loginController.atualizarCarregando(false);
                              Get.off(Home());
                            } catch (e) {
                              loginController.atualizarCarregando(false);
                              Get.dialog(Aviso(
                                titulo: 'Não foi possível fazer login',
                                subTitulo:
                                    'Verique seus dados e sua conexão com a Internet.',
                                color: Colors.red,
                              ));
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
                              'ENTRAR',
                              style: GoogleFonts.quicksand(
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          width: widthScreen - 16,
                          alignment: Alignment.center,
                          child: Container(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.black,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => MaisInfoLogin(),
                          transition: Transition.rightToLeft);
                    },
                    child: Container(
                      width: widthScreen - 16,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 3, color: cor_do_app)),
                      alignment: Alignment.center,
                      child: Text(
                        'SOLICITAR INCLUSÃO DE ATLÉTICA',
                        style: GoogleFonts.quicksand(
                          color: Colors.black,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField textFieldLogin(TextEditingController tcontroller,
      {bool senha = false, bool icon = false}) {
    return TextField(
      controller: tcontroller,
      obscureText: senha,
      decoration: InputDecoration(
        suffixIcon: icon == true
            ? IconButton(
                onPressed: () => loginController.atualizarMonstrandoSenha(),
                icon: Icon(FontAwesomeIcons.eye,
                    color: loginController.monstrandoSenha == true
                        ? Colors.black
                        : Colors.grey),
              )
            : null,
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(40.0),
            ),
            borderSide: BorderSide(color: Colors.grey, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(40.0),
            ),
            borderSide: BorderSide(color: Colors.black, width: 2)),
      ),
    );
  }
}
