import 'dart:math';
import 'dart:ui';

import 'package:charts/bar.dart';
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
  int dataSet = 50;
  AnimationController animation;
  BarTween barTween;
  final random = Random();

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    barTween = BarTween(
        Bar(0.0, Colors.orangeAccent), Bar(50.0, Colors.greenAccent[400]));
    animation.forward();
  }

  void changeData() {
    setState(() {
      barTween = BarTween(
        barTween.evaluate(animation),
        Bar(random.nextDouble() * 100.0, Colors.orangeAccent),
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
          painter: BarChartPainter(barTween.animate(animation)),
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
