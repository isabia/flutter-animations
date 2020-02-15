import 'dart:math';
import 'dart:ui';

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

class ChartPageState extends State<ChartPage> with TickerProviderStateMixin {
  final random = Random();
  int dataSet;

  AnimationController animation;
  double startHeight;
  double currentHeight;
  double endHeight;

  @override
  void initState() {
    dataSet = 0;
    super.initState();
    animation = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..addListener(() {
        setState(() {
          currentHeight = lerpDouble(
            startHeight,
            endHeight,
            animation.value,
          );
        });
      });
    startHeight = 0.0;
    currentHeight = 0.0;
    endHeight = dataSet.toDouble();
    animation.forward();
  }

  void changeData() {
    setState(() {
      startHeight = currentHeight;
      dataSet = random.nextInt(100);
      endHeight = dataSet.toDouble();
      animation.forward(from: 0.0);
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

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }
}
