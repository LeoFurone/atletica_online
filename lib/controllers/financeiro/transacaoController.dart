import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TransacaoController extends GetxController {
  int tipo = 0;

  String fonte = '';

  void atualizarTipo(int novoTipo) {
    tipo = novoTipo;
    update();
  }

  void atualizarFonte(String novaFonte) {
    fonte = novaFonte;
    update();
  }



}