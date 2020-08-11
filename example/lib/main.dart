import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:common_utils/common_utils.dart';

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
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    load();
  }

  Future load() async {
    Response response =
        await Dio().get<dynamic>('');
    // print(response.data['data']['WFC']);
    // List<dynamic> wList = response.data['data'];
    setState(() {
      wfc = response.data['data']['WFC'];
      btc = response.data['data']['BTC'];
      eth = response.data['data']['ETH'];
      _wfcPrice = response.data['data']['data']['WFC'];
      _btcPrice = response.data['data']['data']['BTC'];
      _ethPrice = response.data['data']['data']['ETH'];
      print(wfc);
    });
  }

  List<dynamic> wfc = <dynamic>[];
  List<dynamic> btc = <dynamic>[];
  List<dynamic> eth = <dynamic>[];

  String _wfcPrice;
  String _btcPrice;
  String _ethPrice;

  String get wfcPrice => _wfcPrice ?? '--';
  String get btcPrice => _btcPrice ?? '--';
  String get ethPrice => _ethPrice ?? '--';

  List<LineChartBarData> get lineBarDatas {
    final List<LineChartBarData> res = [];
    res.add(
      LineChartBarData(
        spots: wfcSpot,
        isCurved: false,
        dotData: FlDotData(show: false),
        colors: [
          const Color.fromRGBO(88, 183, 144, 1),
        ],
      ),
    );

    res.add(
      LineChartBarData(
        spots: btcSpot,
        isCurved: false,
        dotData: FlDotData(show: false),
        colors: [
          const Color.fromRGBO(235, 99, 49, 1),
        ],
      ),
    );

    res.add(
      LineChartBarData(
        spots: ethSpot,
        isCurved: false,
        dotData: FlDotData(show: false),
        colors: [
          const Color.fromRGBO(235, 49, 49, 1),
        ],
      ),
    );

    return res;
  }

  List<FlSpot> get wfcSpot {
    final List<FlSpot> res = [];

    for (var i = 0; i < wfc.length; i++) {
      final double y = NumUtil.getDoubleByValueStr(wfc[i]['changes']);
      final double x = i.toDouble();
      res.add(FlSpot(x, y));
    }
    return res;
  }

  List<FlSpot> get btcSpot {
    final List<FlSpot> res = [];

    for (var i = 0; i < wfc.length; i++) {
      final double y = NumUtil.getDoubleByValueStr(btc[i]['changes']);
      final double x = i.toDouble();
      res.add(FlSpot(x, y));
    }
    return res;
  }

  List<FlSpot> get ethSpot {
    final List<FlSpot> res = [];

    for (var i = 0; i < wfc.length; i++) {
      final double y = NumUtil.getDoubleByValueStr(eth[i]['changes']);
      final double x = i.toDouble();
      res.add(FlSpot(x, y));
    }
    return res;
  }

  double get minY {
    double res = double.maxFinite;
    for (List<dynamic> list in [wfcSpot, btcSpot, ethSpot]) {
      for (FlSpot spot in list) {
        res = min(spot.y, res);
      }
    }
    return res;
  }

  double get maxY {
    double res = -double.maxFinite;
    for (List<dynamic> list in [wfcSpot, btcSpot, ethSpot]) {
      for (FlSpot spot in list) {
        res = max(spot.y, res);
      }
    }
    return res;
  }

  String dateStrAtIndex(int index) {
    DateTime dateTime = DateTime.parse(wfc.first['time']);
    dateTime = dateTime.add(Duration(days: index));
    return '${dateTime.month}/${dateTime.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            height: 400,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              width: 4,
                              height: 4,
                              color: const Color.fromRGBO(88, 183, 144, 1),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
                            child: Text(
                              'WFC:$wfcPrice',
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              width: 4,
                              height: 4,
                              color: const Color.fromRGBO(235, 99, 49, 1),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
                            child: Text(
                              'BTC:$btcPrice',
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              width: 4,
                              height: 4,
                              color: const Color.fromRGBO(235, 49, 49, 1),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
                            child: Text(
                              'ETH:$ethPrice',
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: LineChart(
                      LineChartData(
                        minY: minY.floorToDouble(),
                        maxY: maxY.ceilToDouble(),
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
                            reservedSize: 30,
                            margin: 15,
                            interval: 1,
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                            getTitles: (value) {
                              return '${value.toInt()}%';
                            },
                            checkToShowTitle:
                                (minValue, maxValue, sideTitles, appliedInterval, value) {
                              return value.toInt() % 2 == 0;
                            },
                          ),
                          bottomTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 0,
                            margin: 10,
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                            interval: (wfcSpot.length / 6).floorToDouble(),
                            getTitles: (value) {
                              return dateStrAtIndex(value.toInt());
                            },
                            checkToShowTitle:
                                (minValue, maxValue, sideTitles, appliedInterval, value) {
                              return value.toInt() % appliedInterval == 0;
                            },
                          ),
                        ),
                        extraLinesData: ExtraLinesData(
                          horizontalLines: [
                            HorizontalLine(
                              y: wfcSpot.last.y,
                              color: Colors.transparent,
                              label: HorizontalLineLabel(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                show: true,
                                labelResolver: (line) {
                                  return '${wfcSpot.last.y.toInt()}%';
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
