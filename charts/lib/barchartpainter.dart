import 'dart:ui';

import 'package:flutter/material.dart';

import 'bar.dart';

class BarChartPainter extends CustomPainter {
  BarChartPainter(Animation<BarChart> animation)
      : animation = animation,
        super(repaint: animation);

  final Animation<BarChart> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final barPaint = Paint()..style = PaintingStyle.fill;
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeWidth = 1.0;
    final linePath = Path();
    final chart = animation.value;
    for (final group in chart.groups) {
      for (final stack in group.stacks) {
        var y = size.height;
        for (final bar in stack.bars) {
          barPaint.color = bar.color;
          canvas.drawRect(
            Rect.fromLTWH(
              stack.x,
              y - bar.height,
              stack.width,
              bar.height,
            ),
            barPaint,
          );
          if (y < size.height) {
            linePath.moveTo(stack.x, y);
            linePath.lineTo(stack.x + stack.width, y);
          }
          y -= bar.height;
        }
        canvas.drawPath(linePath, linePaint);
        linePath.reset();
      }
    }
  }

  @override
  bool shouldRepaint(BarChartPainter old) => false;
}
