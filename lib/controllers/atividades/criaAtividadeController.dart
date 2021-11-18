import 'package:get/get.dart';

class CriaAtividadeController extends GetxController {

  List subtasks = [];

  void adicionaSubtask(dynamic value){
    subtasks.add(value);
    update();
  }

  void removeSubtask(int value){
    subtasks.removeAt(value);
    update();
  }

  void atualizarCheckboxSubtask(int index, bool? value) {
    subtasks[index][subtasks[index].keys.first] = value;
    update();
  }

  void atualizarSubstasks(List lista) {
    subtasks = lista;
    update();
  }

  DateTime data = DateTime.now();

  void atualizaData(DateTime date) {
    data = date;
    update();
  }

  String tag = '';

  void atualizaTag(String newTag) {
    tag = newTag;
    update();
  }
}