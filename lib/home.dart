import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:atletica_online/components/colors';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controllers/menuController.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MenuController menuController = Get.put(MenuController());

    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var safeArea = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: widthScreen,
            alignment: Alignment.topCenter,
            child: GetBuilder<MenuController>(
                init: MenuController(),
                builder: (_) {
                  if (menuController.index == 0) {
                    return pagina1(heightScreen, widthScreen, safeArea);
                  } else if (menuController.index == 1) {
                    return Container(
                      height: heightScreen - (heightScreen * 0.1) + 15,
                      width: widthScreen,
                      color: Colors.grey[100],
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(height: safeArea, color: azul_principal),
                            Container(
                              width: widthScreen,
                              decoration: BoxDecoration(
                                  color: azul_principal,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(30))),
                              child: Column(
                                children: [
                                  SizedBox(height: 16),
                                  Text(
                                    'Caixa Atual'.toUpperCase(),
                                    style: GoogleFonts.quicksand(
                                      fontSize: 14,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  Text(
                                    'R\$ 1.500,43',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 32),
                                  Text(
                                    'Março'.toUpperCase(),
                                    style: GoogleFonts.quicksand(
                                      fontSize: 14,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.arrowUp,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 8),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Recebido'.toUpperCase(),
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Text(
                                                    'R\$ 200,00',
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'Gastado'.toUpperCase(),
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Text(
                                                    'R\$ 140,00',
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 8),
                                              Icon(
                                                FontAwesomeIcons.arrowDown,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 32),
                                ],
                              ),
                            ),
                            SizedBox(height: 32),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                'GASTOS',
                                style: GoogleFonts.raleway(
                                  color: azul_principal,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4),
                              child: Container(
                                width: widthScreen,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 32),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                'RECEBIDOS',
                                style: GoogleFonts.raleway(
                                  color: azul_principal,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4),
                              child: Container(
                                width: widthScreen,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 32),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                'ALGUM GRÁFICO AQUI',
                                style: GoogleFonts.raleway(
                                  color: azul_principal,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4),
                              child: Container(
                                width: widthScreen,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: PieChart(PieChartData(
                                    borderData: FlBorderData(show: false),
                                    sections: [
                                      PieChartSectionData(
                                          value: 40,
                                          titleStyle: GoogleFonts.quicksand(),
                                          color: Colors.green),
                                      PieChartSectionData(
                                        value: 60,
                                        titleStyle: GoogleFonts.quicksand(),
                                      ),
                                    ])),
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                    );
                  } else if (menuController.index == 2) {
                    return Center(child: Text('tarefas'));
                  } else if (menuController.index == 3) {
                    return Center(child: Text('patrimônio'));
                  } else if (menuController.index == 4) {
                    return Container(
                      height: heightScreen - (heightScreen * 0.1) + 15,
                      width: widthScreen,
                      color: Colors.grey[100],
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: safeArea),
                            Container(
                                height: 70,
                                width: widthScreen,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 8),
                                    Icon(FontAwesomeIcons.infoCircle ,),
                                    SizedBox(width: 8),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Título opções',
                                          style: GoogleFonts.quicksand(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: azul_principal
                                          ),
                                        ),
                                        Text(
                                            'Descrição que vai ser apresentada embaixo')
                                      ],
                                    )
                                  ],
                                )),
                            Container(
                              width: widthScreen - 32,
                              height: 0.7,
                              color: Colors.grey,
                            ),
                            Container(
                                height: 70,
                                width: widthScreen,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 8),
                                    Icon(FontAwesomeIcons.infoCircle ,),
                                    SizedBox(width: 8),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Título opções',
                                          style: GoogleFonts.quicksand(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: azul_principal
                                          ),
                                        ),
                                        Text(
                                            'Descrição que vai ser apresentada embaixo')
                                      ],
                                    )
                                  ],
                                )),
                            Container(
                              width: widthScreen - 32,
                              height: 0.7,
                              color: Colors.grey,
                            ),
                            Container(
                                height: 70,
                                width: widthScreen,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 8),
                                    Icon(FontAwesomeIcons.infoCircle ,),
                                    SizedBox(width: 8),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Título opções',
                                          style: GoogleFonts.quicksand(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: azul_principal
                                          ),
                                        ),
                                        Text(
                                            'Descrição que vai ser apresentada embaixo')
                                      ],
                                    )
                                  ],
                                )),
                            Container(
                              width: widthScreen - 32,
                              height: 0.7,
                              color: Colors.grey,
                            ),
                            Container(
                                height: 70,
                                width: widthScreen,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 8),
                                    Icon(FontAwesomeIcons.infoCircle ,),
                                    SizedBox(width: 8),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Título opções',
                                          style: GoogleFonts.quicksand(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: azul_principal
                                          ),
                                        ),
                                        Text(
                                            'Descrição que vai ser apresentada embaixo')
                                      ],
                                    )
                                  ],
                                )),
                            Container(
                              width: widthScreen - 32,
                              height: 0.7,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Text('erro');
                }),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: heightScreen * 0.1,
              width: widthScreen,
              decoration: BoxDecoration(
                color: azul_principal,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      menuController.atualizarIndex(0);
                    },
                    child: GetBuilder<MenuController>(
                      init: MenuController(),
                      builder: (_) {
                        if (menuController.index == 0) {
                          return itemMenu(heightScreen, FontAwesomeIcons.home,
                              'Home', true);
                        } else {
                          return itemMenu(heightScreen, FontAwesomeIcons.home,
                              'Home', false);
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      menuController.atualizarIndex(1);
                    },
                    child: GetBuilder<MenuController>(
                      init: MenuController(),
                      builder: (_) {
                        if (menuController.index == 1) {
                          return itemMenu(heightScreen,
                              FontAwesomeIcons.dollarSign, 'Financeiro', true);
                        } else {
                          return itemMenu(heightScreen,
                              FontAwesomeIcons.dollarSign, 'Financeiro', false);
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      menuController.atualizarIndex(2);
                    },
                    child: GetBuilder<MenuController>(
                      init: MenuController(),
                      builder: (_) {
                        if (menuController.index == 2) {
                          return itemMenu(heightScreen,
                              FontAwesomeIcons.calendarAlt, 'Tarefas', true);
                        } else {
                          return itemMenu(heightScreen,
                              FontAwesomeIcons.calendarAlt, 'Tarefas', false);
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      menuController.atualizarIndex(3);
                    },
                    child: GetBuilder<MenuController>(
                      init: MenuController(),
                      builder: (_) {
                        if (menuController.index == 3) {
                          return itemMenu(heightScreen,
                              FontAwesomeIcons.boxOpen, 'Patrimônio', true);
                        } else {
                          return itemMenu(heightScreen,
                              FontAwesomeIcons.boxOpen, 'Patrimônio', false);
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      menuController.atualizarIndex(4);
                    },
                    child: GetBuilder<MenuController>(
                      init: MenuController(),
                      builder: (_) {
                        if (menuController.index == 4) {
                          return itemMenu(heightScreen, FontAwesomeIcons.cog,
                              'Opções', true);
                        } else {
                          return itemMenu(heightScreen, FontAwesomeIcons.cog,
                              'Opções', false);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container pagina1(double heightScreen, double widthScreen, double safeArea) {
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
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                    child: Text(
                      'ÚLTIMO AVISO',
                      style: GoogleFonts.raleway(
                        color: azul_principal,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'ACONTECIMENTOS RECENTES',
                      style: GoogleFonts.raleway(
                        color: azul_principal,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'MINHAS PRÓXIMAS REUNIÕES',
                      style: GoogleFonts.raleway(
                        color: azul_principal,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 108,
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          itemReunioes('Esportes AAATU', '23/03', '23H'),
                          itemReunioes('Eventos AAATU', '24/03', '21H'),
                          itemReunioes('Reunião Geral do Juli', '24/03', '23H'),
                        ],
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

  Padding itemReunioes(String titulo, String data, String hora) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                data + ' - ' + hora,
                style: TextStyle(color: Colors.black54),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    titulo.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 24,
                      color: vermelho_secundario,
                    ),
                    maxLines: 2,
                  ),
                ),
              )
            ],
          ),
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

  Container itemMenu(
      double heightScreen, dynamic icon, String name, bool selecionado) {
    return Container(
      color: azul_principal,
      height: heightScreen * 0.09,
      width: heightScreen * 0.09,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              icon,
              color: selecionado ? Colors.white : Colors.grey[400],
              size: heightScreen * 0.048 - 12,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              name,
              style: GoogleFonts.quicksand(
                color: selecionado ? Colors.white : Colors.grey[400],
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
