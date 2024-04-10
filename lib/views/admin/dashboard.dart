import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoster/utils/shared.dart';
import 'package:pie_chart/pie_chart.dart' as pie;

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _lineChartState = false;
  int _lineChartIndex = 0;

  final Map<String, List<List<double>>> _data = <String, List<List<double>>>{
    "Sales per week": <List<double>>[
      for (int index = 0; index < 10; index += 1) <double>[index.toDouble(), Random().nextInt(100) * Random().nextDouble()]
    ],
    "Sales per month": <List<double>>[
      for (int index = 0; index < 10; index += 1) <double>[index.toDouble(), Random().nextInt(100) * Random().nextDouble()]
    ],
    "Sales per year": <List<double>>[
      for (int index = 0; index < 10; index += 1) <double>[index.toDouble(), Random().nextInt(100) * Random().nextDouble()]
    ],
  };

  final GlobalKey<State<StatefulWidget>> _lineChartKey = GlobalKey<State<StatefulWidget>>();

  final Map<String, double> _dataMap = <String, double>{
    "Personal Client": 5,
    "Entreprise Client": 5,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Center(
            child: StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) _) {
                return InkWell(
                  splashColor: transparent,
                  highlightColor: transparent,
                  hoverColor: transparent,
                  onHover: (bool value) => _(() => _lineChartState = value),
                  onTap: () {
                    _(() => _lineChartIndex = (++_lineChartIndex) % 3);
                    _lineChartKey.currentState!.setState(() {});
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AnimatedContainer(
                        duration: 300.ms,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: _lineChartState ? dark : yellow, borderRadius: BorderRadius.circular(5)),
                        child: AnimatedDefaultTextStyle(
                          duration: 300.ms,
                          style: GoogleFonts.abel(letterSpacing: 2, fontSize: 16, fontWeight: FontWeight.w500, color: _lineChartState ? yellow : dark),
                          child: Text(_data.keys.elementAt(_lineChartIndex)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StatefulBuilder(
              key: _lineChartKey,
              builder: (BuildContext context, void Function(void Function()) _) {
                return LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      rightTitles: const AxisTitles(sideTitles: SideTitles()),
                      topTitles: const AxisTitles(sideTitles: SideTitles()),
                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (double value, TitleMeta meta) => value % 10 == 0 ? Text(value.toStringAsFixed(0)) : const SizedBox())),
                      bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (double value, TitleMeta meta) => Text(value.toStringAsFixed(0)))),
                    ),
                    lineBarsData: <LineChartBarData>[
                      LineChartBarData(
                        spots: _data[_data.keys.elementAt(_lineChartIndex)]!.map((List<double> e) => FlSpot(e.first, e.last)).toList(),
                        color: yellow,
                        isCurved: true,
                        barWidth: 3,
                        preventCurveOverShooting: true,
                        belowBarData: BarAreaData(show: true, gradient: LinearGradient(colors: <Color>[yellow.withOpacity(.5), lightWhite])),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: pie.PieChart(
              dataMap: _dataMap,
              animationDuration: 800.ms,
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              colorList: const <Color>[yellow, dark],
              initialAngleInDegree: 0,
              chartType: pie.ChartType.ring,
              ringStrokeWidth: 32,
              centerText: "CLIENTS",
              legendOptions: pie.LegendOptions(
                showLegendsInRow: false,
                legendPosition: pie.LegendPosition.right,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: GoogleFonts.abel(fontWeight: FontWeight.bold),
              ),
              chartValuesOptions: const pie.ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: false,
                decimalPlaces: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
