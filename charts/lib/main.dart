import 'dart:math';

import 'package:flutter/material.dart';

import 'barchartpainter.dart';

void main() {
  runApp(MaterialApp(
    home: ChartPage(),
    theme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.orange,
    ),
    darkTheme:
        ThemeData(brightness: Brightness.dark, primarySwatch: Colors.orange),
    debugShowCheckedModeBanner: false,
  ));
}

class ChartPage extends StatefulWidget {
  @override
  ChartPageState createState() => ChartPageState();
}

class ChartPageState extends State<ChartPage> {
  final random = Random();
  int dataSet;

  @override
  void initState() {
    dataSet = 0;
    super.initState();
  }

  void changeData() {
    setState(() {
      dataSet = random.nextInt(100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          size: Size(200.0, 100.0),
          painter: BarChartPainter(dataSet.toDouble()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: changeData,
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}
