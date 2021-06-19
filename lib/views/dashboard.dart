import 'package:atletica_online/components/breakpoints.dart';
import 'package:atletica_online/components/tituloSessao.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:atletica_online/components/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatelessWidget {
  final double heightScreen;
  final double widthScreen;
  final double safeArea;

  const Dashboard(
      {Key? key,
      required this.heightScreen,
      required this.widthScreen,
      required this.safeArea})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightScreen - (heightScreen * 0.1) + 15,
      width: widthScreen,
      color: Colors.grey[100],
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: safeArea,
              width: widthScreen,
              color: azul_principal,
            ),
            Container(
              width: widthScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  TituloSessao(titulo: "último aviso"),
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      decoration: BoxDecoration(
                          color: azul_principal,
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Acabou de sair um vídeo no Insta sobre mulheres no mundo do esporte e e-sports vão lá conferir e compartilhar com os migoos!",
                              style: GoogleFonts.quicksand(color: Colors.white),
                            ),
                            SizedBox(height: 16),
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.solidThumbsUp,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      'Belezera'.toUpperCase(),
                                      style: GoogleFonts.raleway(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.link,
                                      color: azul_principal,
                                      size: 16,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      'link'.toUpperCase(),
                                      style: GoogleFonts.raleway(
                                        color: azul_principal,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  TituloSessao(titulo: "acontecimentos recentes"),
                  SizedBox(height: 4),
                  itemAcontecimento(
                      widthScreen,
                      'Foi gasto 320 reais. Motivo: Compra bola de basquete.',
                      'Furone',
                      '18:42',
                      FontAwesomeIcons.dollarSign),
                  itemAcontecimento(
                      widthScreen,
                      'A bola de futsal foi retirada.',
                      'Furone',
                      '17:21',
                      FontAwesomeIcons.futbol),
                  itemAcontecimento(
                      widthScreen,
                      'O produto Camiseta de Jogo foi entregue a Rodrigo Zanco.',
                      'Furone',
                      '17:14',
                      FontAwesomeIcons.peopleCarry),
                  itemAcontecimento(
                      widthScreen,
                      'Finalizou a tarefa: "Falar com o Cotil".',
                      'Furone',
                      '16:23',
                      FontAwesomeIcons.check),
                  SizedBox(height: 32),
                  TituloSessao(titulo: "Minhas próximas reuniões"),
                  SizedBox(height: 4),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 300),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(width: 8),
                            itemReunioes('Esportes AAATU', '23/03', '23H'),
                            itemReunioes('Eventos', '24/03', '21H'),
                            itemReunioes('RG do Juli', '24/03', '23H'),
                            itemReunioes('MARKETING', '25/03', '12H'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding itemAcontecimento(double widthScreen, String titulo, String pessoa,
      String hora, IconData icone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: vermelho_secundario,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: Icon(
                  icone,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: widthScreen - 24 - 40 - 16,
                    child: Text(titulo,
                        style: GoogleFonts.raleway(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: widthScreen - 24 - 40 - 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Row(
                          children: [
                            Icon(FontAwesomeIcons.user, size: 14),
                            SizedBox(width: 4),
                            Text(
                              pessoa,
                              style: GoogleFonts.raleway(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                hora,
                                style: GoogleFonts.raleway(
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                FontAwesomeIcons.clock,
                                size: 14,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding itemReunioes(String titulo, String data, String hora) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: azul_principal,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        data.substring(0, 2),
                        style: GoogleFonts.montserrat(color: Colors.white),
                      ),
                      Text(
                        data.substring(3, 5),
                        style: GoogleFonts.montserrat(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4),
              SizedBox(
                width: widthScreen < 768  ? widthScreen / 4 : widthScreen / 8,
                child: Text(
                  titulo.toUpperCase(),
                  style: GoogleFonts.quicksand(
                    color: azul_principal,
                    letterSpacing: 1.25,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 4),
              SizedBox(
                width: widthScreen < tablet  ? widthScreen / 4 : widthScreen / 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.clock, size: 12),
                    SizedBox(width: 4),
                    Text(
                      hora,
                      style: GoogleFonts.quicksand(
                        color: Colors.black,
                        letterSpacing: 1.25,
                        fontSize: 10,
                      ),
                      maxLines: 3,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
