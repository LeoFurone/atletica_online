import 'package:atletica_online/components/myAppBar.dart';
import 'package:atletica_online/components/tituloSessao.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraficosFinanceiro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var safeArea = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyAppBar(title: 'Relatório Financeiro', back: true),
            SizedBox(height: 8),
            TituloSessao(titulo: 'dinheiro por fonte financeira'),
            Center(
              child: Container(
                width: widthScreen - 16,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: PieChart(
                        PieChartData(
                          borderData: FlBorderData(show: true),
                          centerSpaceRadius: 25,
                          sectionsSpace: 5,
                          sections: getSections(),
                        )
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        color: Colors.blue,
                        width: 100,
                        height: 125,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> getSections() {
    List<PieChartSectionData> result = [];

    result.add(PieChartSectionData(
      value: 15,
      color: Colors.blue,
      title: '15%',
      titleStyle: TextStyle(color: Colors.black),
    ));

    result.add(PieChartSectionData(
      value: 85,
      color: Colors.red,
      title: '85%',
      titleStyle: TextStyle(color: Colors.black),
    ));

    return result;
  }
}
