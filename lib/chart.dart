import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pie_chart.dart';

enum LegendShape { Circle, Rectangle }

class ChartPage extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<ChartPage> {
  final dataMap = <String, double>{
    "Study": 40,
    "Exercise": 30,
    "People": 15,
    "Free-time": 15,
  };

  final legendLabels = <String, String>{
    "Flutter": "Flutter legend",
    "React": "React legend",
    "Xamarin": "Xamarin legend",
    "Ionic": "Ionic legend",
  };

  final colorList = <Color>[
    Color(0xfffdcb6e),
    Color(0xff0984e3),
    Color(0xfffd79a8),
    Color(0xffe17055),
    Color(0xff6c5ce7),
  ];

  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ]
  ];
  ChartType? _chartType = ChartType.disc;
  bool _showCenterText = false;
  double? _ringStrokeWidth = 32;
  double? _chartLegendSpacing = 48;

  bool _showLegendsInRow = false;
  bool _showLegends = true;
  bool _showLegendLabel = false;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = true;
  bool _showChartValuesOutside = true;

  bool _showGradientColors = false;

  LegendShape? _legendShape = LegendShape.Circle;
  LegendPosition? _legendPosition = LegendPosition.bottom;

  int key = 0;

  @override
  Widget build(BuildContext context) {
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: _chartLegendSpacing!,
      chartRadius: math.min(MediaQuery.of(context).size.width / 3.2, 500),
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType!,
      centerText: _showCenterText ? "HYBRID" : null,
      legendLabels: _showLegendLabel ? legendLabels : {},
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition!,
        showLegends: _showLegends,
        legendShape: _legendShape == LegendShape.Circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth!,
      emptyColor: Colors.grey,
      gradientList: _showGradientColors ? gradientList : null,
      emptyColorGradient: [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
      baseChartColor: Colors.transparent,
    );
    final settings = SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.all(12),
        child: Column(
          children: [
            SwitchListTile(
              value: _showGradientColors,
              title: Text("Show Gradient Colors"),
              onChanged: (val) {
                setState(() {
                  _showGradientColors = val;
                });
              },
            ),
            ListTile(
              title: Text(
                'Pie Chart Options'.toUpperCase(),
                style: Theme.of(context).textTheme.overline!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            ListTile(
              title: Text("chartType"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<ChartType>(
                  value: _chartType,
                  items: [
                    DropdownMenuItem(
                      child: Text("disc"),
                      value: ChartType.disc,
                    ),
                    DropdownMenuItem(
                      child: Text("ring"),
                      value: ChartType.ring,
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _chartType = val;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: Text("ringStrokeWidth"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<double>(
                  value: _ringStrokeWidth,
                  disabledHint: Text("select chartType.ring"),
                  items: [
                    DropdownMenuItem(
                      child: Text("16"),
                      value: 16,
                    ),
                    DropdownMenuItem(
                      child: Text("32"),
                      value: 32,
                    ),
                    DropdownMenuItem(
                      child: Text("48"),
                      value: 48,
                    ),
                  ],
                  onChanged: (_chartType == ChartType.ring)
                      ? (val) {
                          setState(() {
                            _ringStrokeWidth = val;
                          });
                        }
                      : null,
                ),
              ),
            ),
            SwitchListTile(
              value: _showCenterText,
              title: Text("showCenterText"),
              onChanged: (val) {
                setState(() {
                  _showCenterText = val;
                });
              },
            ),
            ListTile(
              title: Text("chartLegendSpacing"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<double>(
                  value: _chartLegendSpacing,
                  disabledHint: Text("select chartType.ring"),
                  items: [
                    DropdownMenuItem(
                      child: Text("16"),
                      value: 16,
                    ),
                    DropdownMenuItem(
                      child: Text("32"),
                      value: 32,
                    ),
                    DropdownMenuItem(
                      child: Text("48"),
                      value: 48,
                    ),
                    DropdownMenuItem(
                      child: Text("64"),
                      value: 64,
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _chartLegendSpacing = val;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Legend Options'.toUpperCase(),
                style: Theme.of(context).textTheme.overline!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SwitchListTile(
              value: _showLegendsInRow,
              title: Text("showLegendsInRow"),
              onChanged: (val) {
                setState(() {
                  _showLegendsInRow = val;
                });
              },
            ),
            SwitchListTile(
              value: _showLegends,
              title: Text("showLegends"),
              onChanged: (val) {
                setState(() {
                  _showLegends = val;
                });
              },
            ),
            SwitchListTile(
              value: _showLegendLabel,
              title: Text("showLegendLabels"),
              onChanged: (val) {
                setState(() {
                  _showLegendLabel = val;
                });
              },
            ),
            ListTile(
              title: Text("legendShape"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<LegendShape>(
                  value: _legendShape,
                  items: [
                    DropdownMenuItem(
                      child: Text("BoxShape.circle"),
                      value: LegendShape.Circle,
                    ),
                    DropdownMenuItem(
                      child: Text("BoxShape.rectangle"),
                      value: LegendShape.Rectangle,
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _legendShape = val;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: Text("legendPosition"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<LegendPosition>(
                  value: _legendPosition,
                  items: [
                    DropdownMenuItem(
                      child: Text("left"),
                      value: LegendPosition.left,
                    ),
                    DropdownMenuItem(
                      child: Text("right"),
                      value: LegendPosition.right,
                    ),
                    DropdownMenuItem(
                      child: Text("top"),
                      value: LegendPosition.top,
                    ),
                    DropdownMenuItem(
                      child: Text("bottom"),
                      value: LegendPosition.bottom,
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _legendPosition = val;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Chart values Options'.toUpperCase(),
                style: Theme.of(context).textTheme.overline!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SwitchListTile(
              value: _showChartValueBackground,
              title: Text("showChartValueBackground"),
              onChanged: (val) {
                setState(() {
                  _showChartValueBackground = val;
                });
              },
            ),
            SwitchListTile(
              value: _showChartValues,
              title: Text("showChartValues"),
              onChanged: (val) {
                setState(() {
                  _showChartValues = val;
                });
              },
            ),
            SwitchListTile(
              value: _showChartValuesInPercentage,
              title: Text("showChartValuesInPercentage"),
              onChanged: (val) {
                setState(() {
                  _showChartValuesInPercentage = val;
                });
              },
            ),
            SwitchListTile(
              value: _showChartValuesOutside,
              title: Text("showChartValuesOutside"),
              onChanged: (val) {
                setState(() {
                  _showChartValuesOutside = val;
                });
              },
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Motive"),
      //   // actions: [
      //   //   ElevatedButton(
      //   //     onPressed: () {
      //   //       setState(() {
      //   //         key = key + 1;
      //   //       });
      //   //     },
      //   //     child: Text("Reload".toUpperCase()),
      //   //   ),
      //   // ],
      // ),
      body: LayoutBuilder(
        builder: (_, constraints) {
          if (constraints.maxWidth >= 600) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: chart,
                ),
                // Flexible(
                //   flex: 2,
                //   fit: FlexFit.tight,
                //   child: settings,
                // )
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {}, child: Text("많이 사용된 시간")),
                      SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: Text("적게 사용된 시간")),
                    ],
                  )),
                  SizedBox(
                    height: 80,
                  ),

                  Container(
                    child: chart,
                    margin: EdgeInsets.symmetric(
                      vertical: 32,
                    ),
                  ),

                  //  settings,
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class HomePage2 extends StatelessWidget {
  HomePage2({Key? key}) : super(key: key);

  final dataMap = <String, double>{
    "Flutter": 5,
  };

  final colorList = <Color>[
    Colors.greenAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pie Chart 1"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: PieChart(
          dataMap: dataMap,
          chartType: ChartType.ring,
          baseChartColor: Colors.grey[50]!.withOpacity(0.15),
          colorList: colorList,
          chartValuesOptions: ChartValuesOptions(
            showChartValuesInPercentage: true,
          ),
          totalValue: 20,
        ),
      ),
    );
  }
}
