import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {

  List<QueryDocumentSnapshot> lista = [];

  String hora_atual = DateTime.now().hour.toString() + ':' + DateTime.now().minute.toString();

  void atualizaHora() {
    hora_atual =  DateTime.now().hour.toString() + ':' + DateTime.now().minute.toString();
    update();
  }

  void atualizaLista(List<QueryDocumentSnapshot> newList) {
    lista = newList;
    update();
  }

}