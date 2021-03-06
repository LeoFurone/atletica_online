import 'package:get/get.dart';

class FinanceiroController extends GetxController {

  double caixa_atual = 0;

  void atualizarCaixaAtual(double newValue){
    caixa_atual = newValue;
    update();
  }

  double recebidos_mes = 0;

  void atualizarRecebidosMes(double newValue){
    recebidos_mes = newValue;
    update();
  }

  double gastos_mes = 0;

  void atualizarGastosMes(double newValue){
    gastos_mes = newValue;
    update();
  }

  List documentsRecebidos = [];

  void atualizarDocumentsRecebidos(List newDocumentsRecebidos){
    documentsRecebidos = newDocumentsRecebidos;
    update();
  }

  List documentsGastos = [];

  void atualizarDocumentsGastos(List newDocumentsGastos) {
    documentsGastos = newDocumentsGastos;
    update();
  }




}