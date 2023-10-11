import 'package:flutter/material.dart';

class CircleModel{
  double x;
  double y;
  final double radius;
  final Color color;
  int horizontalDirection = 1;
  int verticalDirection = -1;

  CircleModel(this.x, this.y, this.radius, this.color);


}

class LineModel{
  double x1;
  double y1;
  double x2;
  double y2;


  LineModel(this.x1, this.y1, this.x2, this.y2);

}