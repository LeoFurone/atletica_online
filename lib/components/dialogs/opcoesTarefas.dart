import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class OpcoesTarefas extends StatefulWidget {
  @override
  _OpcoesTarefasState createState() => _OpcoesTarefasState();
  double posBotton = -80.0;
}

class _OpcoesTarefasState extends State<OpcoesTarefas> {
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
                height: 80,
                width: widthScreen,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 39.75,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.book, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Alguma opção aqui',
                              style: GoogleFonts.montserrat(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    linhaDivisoria(),
                    Container(
                      height: 39.75,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.book, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Alguma opção aqui',
                              style: GoogleFonts.montserrat(),
                            ),
                          ],
                        ),
                      ),
                    ),
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
