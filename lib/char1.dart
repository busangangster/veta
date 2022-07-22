import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'pie_chart.dart';

class Chart1Page extends StatefulWidget {
  @override
  _Chart1PageState createState() => _Chart1PageState();
}

class _Chart1PageState extends State<Chart1Page> {
  final user = FirebaseAuth.instance.currentUser;

  int key = 0;

  late List<Task> _task = [];
  int check = 0;
  Map<String, double> getCategoryData() {
    Map<String, double> catMap = {};
    for (var item in _task) {
      check = check + 1;
      print(item.category);
      if (catMap.containsKey(item.category) == false) {
        catMap[item.category] = 1;
      } else {
        catMap.update(item.category, (double) => catMap[item.category]! + 1);
        // test[item.category] = test[item.category]! + 1;
      }
      print(catMap);
    }
    return catMap;
  }

  /* pidchart에 들어가는 Color */
  final colorList = <Color>[
    Color(0xfffdcb6e),
    Color(0xff0984e3),
    Color(0xfffd79a8),
    Color(0xffe17055),
    Color(0xff6c5ce7),
    Color(0xffec5e87),
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
  bool _showGradientColors = false;

  @override
  Widget build(BuildContext context) {
    void getExpfromSanapshot(snapshot) {
      // 등록한 task의 상태가 Completion 이 되면, piechart 에 들어갈 task 로 추가
      print(snapshot.docs.length);
      if (snapshot.docs.isNotEmpty) {
        //  print("is Empty !");
        _task = [];
        for (int i = 0; i < snapshot.docs.length; i++) {
          //  print("is not Empty !");
          var a = snapshot.docs[i];
          // print(a.data());
          if (a['Completion'] == false) {
          } else {
            Task exp = Task.fromJson(a.data());
            _task.add(exp);
            // print(exp);
          }
        }
      }
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),

                /* data 가 Completion 상태가 될 때마다, piechart update를 위한 StreamBuilder */
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(user!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text("something went wrong");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    final data = snapshot.data!;
                    print("Data: $data");
                    getExpfromSanapshot(data);
                    print("check $check");

                    /* return 값은 pieChart가 구현되어있는 Widget */
                    return pieChartExampleOne();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pieChartExampleOne() {
    return PieChart(
      key: ValueKey(key),
      //dataMap: dataMap,

      /* Completion 된 data중 비율을 표시할 category를 dataMap으로 불러옴 */
      dataMap: getCategoryData(),

      /* piechart 디자인 */
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 48,
      chartRadius: math.min(MediaQuery.of(context).size.width / 3.2, 500),
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.disc,

      legendOptions: const LegendOptions(
          showLegendsInRow: false,
          showLegends: true,
          legendShape: BoxShape.rectangle,
          legendPosition: LegendPosition.right,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
      chartValuesOptions: const ChartValuesOptions(
          showChartValuesOutside: true,
          showChartValuesInPercentage: true,
          showChartValueBackground: true,
          showChartValues: true,
          chartValueStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      ringStrokeWidth: 32,
      emptyColor: Colors.grey,
      gradientList: _showGradientColors ? gradientList : null,
      emptyColorGradient: [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
      baseChartColor: Colors.transparent,

      //centerText: 'Expense',
    );
  }
}

/* 각 Task 별로 들어가는 data들을 Task라는 Class 생성 */
class Task {
  bool Completion;
  String Title;
  String category;
  int priority;
  int time;

  Task(
      {required this.Completion,
      required this.Title,
      required this.category,
      required this.priority,
      required this.time});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      Completion: json['Completion'],
      Title: json['Title'],
      category: json['category'],
      priority: json['priority'],
      time: json['time'],
    );
  }
}
