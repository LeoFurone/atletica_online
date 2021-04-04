import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  int index = 0;

  void atualizarIndex(int newIndex){
    index = newIndex;
    update();
  }
}