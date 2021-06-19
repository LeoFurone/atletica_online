import 'package:get/get.dart';

class LoginController extends GetxController {
  bool carregando = false;

  void atualizarCarregando(bool newCarregando){
    carregando = newCarregando;
    update();
  }

  bool monstrandoSenha = false;

  void atualizarMonstrandoSenha(){
    monstrandoSenha = !monstrandoSenha;
    print('aqui');
    update();
  }
}