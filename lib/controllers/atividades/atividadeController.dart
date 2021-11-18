import 'package:get/get.dart';

class AtividadeController extends GetxController {

  List atividades = [];

  void atualizaAtividades(List newAtividades) {
    atividades = newAtividades;
    update();
  }

  void adicionaAtividade(dynamic item) {
    atividades.add(item);
    update();
  }

  void zeraAtividades(){
    atividades.clear();
    update();
  }

  List atividadesFirebase = [];

  void atualizaAtividadesFirebase(List newAtividades) {
    atividadesFirebase = newAtividades;
    update();
  }

  List tags = [];


  void atualizaTags(List newTags) {
    tags = newTags;
    update();
  }

  String tag = '';

  void atualizaTagSelecionada(String newTag) {
    tag = newTag;
    update();
  }





}