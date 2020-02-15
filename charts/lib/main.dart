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
  int dataSet = 50;
  AnimationController animation;
  Tween<double> tween;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    tween = Tween<double>(begin: 0.0, end: dataSet.toDouble());
    animation.forward();
  }

  void changeData() {
    setState(() {
      dataSet = random.nextInt(100);
      tween = Tween<double>(
        begin: tween.evaluate(animation),
        end: dataSet.toDouble(),
      );
      animation.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          size: Size(200.0, 100.0),
          painter: BarChartPainter(tween.animate(animation)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: changeData,
        backgroundColor: Colors.orangeAccent,
        tooltip: "Tap here for increase the graph",
      ),
    );
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }
}
