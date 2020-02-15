import 'dart:ui';

import 'package:flutter/animation.dart';

class Bar {
  Bar(this.height);

  final double height;

  static Bar lerp(Bar begin, Bar end, double t) {
    return Bar(lerpDouble(begin.height, end.height, t));
  }
}

class BarTween extends Tween<Bar> {
  BarTween(Bar begin, Bar end) : super(begin: begin, end: end);

  @override
  Bar lerp(double t) => Bar.lerp(begin, end, t);
}
