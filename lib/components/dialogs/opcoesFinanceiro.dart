import 'package:atletica_online/views/financeiro/registrarTransacao.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OpcoesFinanceiro extends StatefulWidget {
  @override
  _OpcoesFinanceiroState createState() => _OpcoesFinanceiroState();
  double posBotton = -80.0;
}

class _OpcoesFinanceiroState extends State<OpcoesFinanceiro> {
  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;

    Future.delayed(Duration(milliseconds: 100)).then((value) {
      if (mounted) {
        setState(() {
          widget.posBotton = 0;
        });
      }
    });

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            AnimatedPositioned(
              bottom: widget.posBotton,
              child: Container(
                width: widthScreen,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                        Get.to(() => RegistrarTransacao());
                      },
                      child: item('Adicionar transação', FontAwesomeIcons.fileInvoiceDollar),
                    ),
                    linhaDivisoria(),
                    item('Alguma opção aqui', FontAwesomeIcons.infinity),
                  ],
                ),
              ),
              duration: Duration(milliseconds: 250),
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Container item(String texto, IconData icon) {
    return Container(
      height: 39.75,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Container(
              width: 30,
              child: Icon(icon, size: 20),
            ),
            SizedBox(width: 8),
            Text(
              texto,
              style: GoogleFonts.montserrat(),
            ),
          ],
        ),
      ),
    );
  }

  Padding linhaDivisoria() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}
