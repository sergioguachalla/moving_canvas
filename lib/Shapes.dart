import 'package:flutter/material.dart';
import 'package:moing_canvas/models.dart';

class Circle extends CustomPainter{

  List<CircleModel> circles = [];

  Circle(this.circles);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    circles.forEach((circle) {
      paint.color = circle.color;
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(circle.x, circle.y), circle.radius, paint);

      paint.color = Colors.black;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 2.4;
      canvas.drawCircle(Offset(circle.x, circle.y), circle.radius, paint);

      // Calcular las coordenadas (x2, y2) para el centro de la pantalla
      double x2 = size.width / 2;
      double y2 = size.height / 2;

      paint.color = Colors.black;
      paint.style = PaintingStyle.fill;
      paint.strokeWidth = 1.6;
      canvas.drawLine(Offset(circle.x, circle.y), Offset(x2, y2), paint);
    });
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {

    return true;

  }

}




