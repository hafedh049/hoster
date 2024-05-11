import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoster/utils/shared.dart';
import 'package:http/http.dart';
import 'package:pie_chart/pie_chart.dart' as pie;

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _lineChartState = false;
  int _lineChartIndex = 0;

  Map<String, dynamic> _data = <String, Map<String, dynamic>>{
    "Sales per week": <String, Map<String, dynamic>>{},
    "Sales per month": <String, Map<String, dynamic>>{},
    "Sales per year": <String, Map<String, dynamic>>{},
  };

  final Map<String, dynamic> _x = <String, Map<String, dynamic>>{
    "Sales per week": <String, int>{},
    "Sales per month": <String, int>{},
    "Sales per year": <String, int>{},
  };

  final GlobalKey<State<StatefulWidget>> _lineChartKey = GlobalKey<State<StatefulWidget>>();

  Map<String, double> _dataMap = <String, double>{
    "Personal Client": 5,
    "Entreprise Client": 5,
  };

  Future<Map<String, dynamic>> _fetchData() async {
    try {
      final Map<String, Map<String, dynamic>> dataa = <String, Map<String, dynamic>>{};
      final response = await post(Uri.parse('http://localhost/backend/list_charts.php'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body)['result'];

        dataa['Sales per week'] = Map.from(data['per_week']);
        dataa['Sales per month'] = Map.from(data['per_month']);
        dataa['Sales per year'] = Map.from(data['per_year']);

        for (final String key in dataa['Sales per week']!.keys) {
          _x['Sales per week'][key] = dataa['Sales per week']!.keys.toList().indexOf(key);
        }

        for (final String key in dataa['Sales per month']!.keys) {
          _x['Sales per month'][key] = dataa['Sales per month']!.keys.toList().indexOf(key);
        }
        for (final String key in dataa['Sales per year']!.keys) {
          _x['Sales per year'][key] = dataa['Sales per year']!.keys.toList().indexOf(key);
        }
        return data;
      } else {
        return <String, Map<String, dynamic>>{
          "Sales per week": <String, Map<String, dynamic>>{},
          "Sales per month": <String, Map<String, dynamic>>{},
          "Sales per year": <String, Map<String, dynamic>>{},
        };
      }
    } catch (e) {
      debugPrint('Error: $e');
      return <String, Map<String, dynamic>>{
        "Sales per week": <String, Map<String, dynamic>>{},
        "Sales per month": <String, Map<String, dynamic>>{},
        "Sales per year": <String, Map<String, dynamic>>{},
      };
    }
  }

  Future<Map<String, double>> _fetchClientPercentage() async {
    try {
      final Map<String, double> dataMap = <String, double>{
        "Personal Client": 0,
        "Entreprise Client": 0,
      };
      final response = await post(Uri.parse('http://localhost/backend/pie_chart.php'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body)["result"];
        dataMap['Personal Client'] = data['personal_percentage'];
        dataMap['Entreprise Client'] = data['enterprise_percentage'];
        return dataMap;
      } else {
        return <String, double>{
          "Personal Client": 5,
          "Entreprise Client": 5,
        };
      }
    } catch (e) {
      debugPrint('Error: $e');
      return <String, double>{
        "Personal Client": 5,
        "Entreprise Client": 5,
      };
    }
  }

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
                          child: Text(_data.keys.elementAt(_lineChartIndex).replaceAll("_", " ").toUpperCase()),
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
            child: FutureBuilder<Map<String, dynamic>>(
              future: _fetchData(),
              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasData) {
                  return StatefulBuilder(
                    key: _lineChartKey,
                    builder: (BuildContext context, void Function(void Function()) _) {
                      _data = snapshot.data!;
                      return LineChart(
                        LineChartData(
                          titlesData: FlTitlesData(
                            rightTitles: const AxisTitles(sideTitles: SideTitles()),
                            topTitles: const AxisTitles(sideTitles: SideTitles()),
                            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (double value, TitleMeta meta) => value % 200 == 0 ? Text(value.toStringAsFixed(0)) : const SizedBox())),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (double value, TitleMeta meta) => const Text("" //value.toInt() % 20 != 0 ? "" : _x[_x.keys.elementAt(_lineChartIndex)].keys.elementAt(value.toInt()),
                                    ),
                              ),
                            ),
                          ),
                          lineBarsData: <LineChartBarData>[
                            LineChartBarData(
                              spots: _data[_data.keys.elementAt(_lineChartIndex)]!.entries.map((dynamic e) => FlSpot(_x[_x.keys.elementAt(_lineChartIndex)][e.key].toDouble(), e.value.toDouble())).toList().cast<FlSpot>(),
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
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Center(child: Text("Something went wrong : ${snapshot.error}"));
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<Map<String, double>>(
              future: _fetchClientPercentage(),
              builder: (BuildContext context, AsyncSnapshot<Map<String, double>> snapshot) {
                if (snapshot.hasData) {
                  _dataMap = snapshot.data!;
                  return pie.PieChart(
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
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Center(child: Text("Something went wrong : ${snapshot.error}"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
