import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Expanded(
            child: LineChart(),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: PieChart(),
          ),
        ],
      ),
    );
  }
}
