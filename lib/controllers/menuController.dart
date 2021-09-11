import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  int index = 0;

  void atualizarIndex(int newIndex){
    index = newIndex;
    update();
  }

  bool temAtletica = false;

  void atualizarTemAtletica(bool novoTemAtletica) {
    temAtletica = novoTemAtletica;
    update();
  }

  bool criouUsuario = false;

  void atualizarCriouUsuario(bool novoCriouUsuario) {
    criouUsuario = novoCriouUsuario;
    update();
  }
}