import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var safeArea = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: safeArea),
          // add
          GestureDetector(
            onTap: () {
              print('clicado');
              Map<String,dynamic> dadosApp = {
                "nome": "dudu",
                "sobrenome": "furone"
              };

              CollectionReference collectionReference = FirebaseFirestore.instance.collection('dados');
              collectionReference.add(dadosApp);
            },
            child: Container(
              color: Colors.blue,
              width: widthScreen,
              height: 60,
              child: Center(child: Text("Enviar dados")),
            ),
          ),
          SizedBox(height: 16),
          // buscar
          GestureDetector(
            onTap: () {
              CollectionReference collectionReference = FirebaseFirestore.instance.collection('dados');
              collectionReference.snapshots().listen((snapshot) {

                List<QueryDocumentSnapshot> documents = snapshot.docs;

                for (var doc in documents) {
                  print(doc.data());
                  print(doc.data()['nome']);
                }


              });
            },
            child: Container(
              color: Colors.green,
              width: widthScreen,
              height: 60,
              child: Center(child: Text("Buscar dados")),
            ),
          ),
          SizedBox(height: 16),
          // excluir
          GestureDetector(
            onTap: () async {
              CollectionReference collectionReference = FirebaseFirestore.instance.collection('dados');
              QuerySnapshot querySnapshot = await collectionReference.get();
              querySnapshot.docs[1].reference.delete();
            },
            child: Container(
              color: Colors.red,
              width: widthScreen,
              height: 60,
              child: Center(child: Text("Excluir dados")),
            ),
          ),
          SizedBox(height: 16),
          // atualizar
          GestureDetector(
            onTap: () async {

              Map<String,dynamic> dadosUpdate = {
                "nome": "carlos",
                "sobrenome": "furone"
              };

              CollectionReference collectionReference = FirebaseFirestore.instance.collection('dados');
              QuerySnapshot querySnapshot = await collectionReference.get();
              querySnapshot.docs[1].reference.update(dadosUpdate);
            },
            child: Container(
              color: Colors.yellow,
              width: widthScreen,
              height: 60,
              child: Center(child: Text("Atualizar dados")),
            ),
          ),


        ],
      ),
    );
  }
}
