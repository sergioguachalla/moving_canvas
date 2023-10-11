import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'Shapes.dart';
import 'models.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

enum Mode{
  none,
  add,
  remove
}

class _HomeState extends State<Home> {

  List<CircleModel> circles = [];
  List<LineModel> lines = [];
  Mode mode = Mode.none;


  @override
  void initState() {
    super.initState();
    thread();
  }

  Future thread() async {
    Completer completer = Completer();
    Timer(
      Duration(milliseconds: 10),
        (){
          completer.complete(moveDiagonal());
        }
    );
  }

    move(){
      setState(() {
        circles.forEach((circle){
          if(circle.horizontalDirection == 1){
            if(circle.x  + circle.radius/2 >= MediaQuery.of(context).size.width){
              circle.horizontalDirection = -1;
            }
            else{
              if(circle.x - circle.radius/2 <= 0){
                circle.horizontalDirection = 1;
              }
            }

          }
          circle.x = circle.x + circle.horizontalDirection*2;
        });
        thread();
      });
    }


  moveDiagonal() {
    setState(() {
      circles.forEach((circle) {
        if (circle.x + circle.radius / 2 >= MediaQuery.of(context).size.width ||
            circle.x - circle.radius / 2 <= 0) {
          circle.horizontalDirection = -circle.horizontalDirection;
        }
        if (circle.y + circle.radius / 2 >= MediaQuery.of(context).size.height ||
            circle.y - circle.radius / 2 <= 0) {
          circle.verticalDirection = -circle.verticalDirection;
        }
        circle.x = circle.x + circle.horizontalDirection * 3;
        circle.y = circle.y + circle.verticalDirection * 3;
      });
      thread();
    });
  }




  Random random = Random();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: Circle(circles),
            child: Container(),
          ),

          GestureDetector(
            onPanDown: (details){
              setState(() {
                if(mode == Mode.add){
                  Color color = Color.fromRGBO(
                    random.nextInt(256),
                    random.nextInt(256),
                    random.nextInt(256),
                    10000
                  );
                  circles.add(CircleModel(details.localPosition.dx, details.localPosition.dy, random.nextDouble()*(screenSize.width/16), color));
                }else if(mode == Mode.remove){
                  circles.removeWhere((element) => (element.x - details.localPosition.dx).abs() < 20 && (element.y - details.localPosition.dy).abs() < 20);
                }
              });
            }
          )
        ],

      ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.add_circle,
                  color: (mode == Mode.add)?Colors.white : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    mode = Mode.add;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.remove_circle,
                color: (mode == Mode.remove) ? Colors.white: Colors.black,),
                onPressed: () {
                  setState(() {
                    mode = Mode.remove;
                  });
                },
              ),
            ],
          )
        ),
    );
  }
}
