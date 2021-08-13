import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditaFontesController extends GetxController {

  List<QueryDocumentSnapshot>? documentsAtivos = null;

  void atualizarDocumentosAtivos(List<QueryDocumentSnapshot> newDocuments) {
    documentsAtivos = newDocuments;
    update();
  }

  List<QueryDocumentSnapshot> documentsNaoAtivos = [];

  void atualizarDocumentosNaoAtivos(List<QueryDocumentSnapshot> newDocuments) {
    documentsNaoAtivos = newDocuments;
    update();
  }


}