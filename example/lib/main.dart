import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlChart Demo',
      showPerformanceOverlay: false,
      theme: ThemeData(
        primaryColor: const Color(0xff262545),
        primaryColorDark: const Color(0xff201f39),
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'fl_chart'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<LineChartBarData> get lineBarDatas {
    final List<LineChartBarData> res = [];
    res.add(
      LineChartBarData(
        spots: cosSpot,
        isCurved: false,
        dotData: FlDotData(show: false),
        colors: [
          Colors.red,
        ],
      ),
    );

    return res;
  }

  List<FlSpot> get cosSpot {
    final List<FlSpot> res = [];
    for (int i = 0; i <= 360; i++) {
      final double y = sin(pi * i / 180);
      final double x = i.toDouble();
      res.add(
        FlSpot(x, y),
      );
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: 300,
            width: 300,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Expanded(
                      child: Text(
                        'WFC',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'BTC',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'USDT',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                LineChart(
                  LineChartData(
                    lineBarsData: lineBarDatas,
                    titlesData: FlTitlesData(
                      leftTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 0,
                        margin: 0,
                        checkToShowTitle:
                            (minValue, maxValue, sideTitles, appliedInterval, value) => false,
                      ),
                      rightTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        margin: 15,
                        interval: 0.2,
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                        getTitles: (value) {
                          return '23444';
                        },
                      ),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 0,
                        margin: 10,
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                        checkToShowTitle: (minValue, maxValue, sideTitles, appliedInterval, value) {
                          return value.toInt() % 30 == 0;
                        },
                      ),
                    ),
                    extraLinesData: ExtraLinesData(
                      horizontalLines: [
                        HorizontalLine(
                          y: cosSpot.last.y,
                          color: Colors.transparent,
                          label: HorizontalLineLabel(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            show: true,
                            labelResolver: (line) {
                              return '${4444}';
                            },
                          ),
                        ),
                      ],
                    ),
                    borderData: FlBorderData(
                      border: Border(
                        left: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                        right: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                        bottom: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    lineTouchData: LineTouchData(
                      enabled: false,
                    ),
                    gridData: FlGridData(
                      show: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
