import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {

  List<QueryDocumentSnapshot> lista = [];

  String hora_atual = DateTime.now().hour.toString() + ':' + DateTime.now().minute.toString();

  void atualizaHora() {
    String hora = DateTime.now().hour.toString().length > 1 ? DateTime.now().hour.toString() : '0' + DateTime.now().hour.toString();
    String minuto = DateTime.now().minute.toString().length > 1 ? DateTime.now().minute.toString() : '0' + DateTime.now().minute.toString();
    hora_atual =  hora + ':' + minuto;
    update();
  }

  void atualizaLista(List<QueryDocumentSnapshot> newList) {
    lista = newList;
    update();
  }

}