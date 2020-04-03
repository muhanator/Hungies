import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:hungies/widgets/secondary_card.dart';
import 'package:hungies/constants.dart';
import '../widgets/primary_card.dart';
import '../data.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() =>  HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  int flag = 0;

  List data = imageData;
  List selectedData = [];
  void initState() {
    super.initState();

    _buttonController =  AnimationController(
        duration:  Duration(milliseconds: 1000), vsync: this);

    rotate =  Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
       CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          var i = data.removeLast();
          data.insert(0, i);

          _buttonController.reset();
        }
      });
    });

    right =  Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
       CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    bottom =  Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
       CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    width =  Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
       CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _swipeAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  dismissImg(DecorationImage img) {
    setState(() {
      data.remove(img);
    });
  }

  addImg(DecorationImage img) {
    setState(() {
      data.remove(img);
      selectedData.add(img);
    });
  }

  swipeRight() {
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    _swipeAnimation();
  }

  swipeLeft() {
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    _swipeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;

    double initialBottom = 15.0;
    var dataLength = data.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = -10.0;
    return  Scaffold(
        appBar:  AppBar(
          brightness: Brightness.dark,
          elevation: 0.0,
          backgroundColor: DARK_GREY,
          centerTitle: true,
          leading:  Container(
            margin: const EdgeInsets.all(15.0),
            child:  Icon(
              Icons.message,
              color: GREEN,
              size:25.0,
            ),
          ),
          actions: <Widget>[
             GestureDetector(
              onTap: () {
              },
              child:  Container(
                  margin: const EdgeInsets.all(15.0),
                  child:  Icon(
                    Icons.account_circle,
                    color: GREEN,
                    size: 30.0,
                  )),
            ),
          ],
          title:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Text(
                "Hungies",
                style:  TextStyle(
                    fontSize: 20,
                    color: GREEN,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        body:  Container(
          color: DARK_GREY,
          alignment: Alignment.center,
          child: dataLength > 0
              ?  Stack(
                  alignment: AlignmentDirectional.center,
                  children: data.map((item) {
                    if (data.indexOf(item) == dataLength - 1) {
                      return PrimaryCard(
                          item,
                          bottom.value,
                          right.value,
                          0.0,
                          backCardWidth + 10,
                          rotate.value,
                          rotate.value < -10 ? 0.1 : 0.0,
                          context,
                          dismissImg,
                          flag,
                          addImg,
                          swipeRight,
                          swipeLeft);
                    } else {
                      backCardPosition = backCardPosition - 10;
                      backCardWidth = backCardWidth + 10;

                      return SecondaryCard(item, backCardPosition, 0.0, 0.0,
                          backCardWidth, 0.0, 0.0, context);
                    }
                  }).toList())
              :  Text("No restaurants left in to area",
                  style:  TextStyle(color: Colors.white, fontSize: 50.0)),
        ));
  }
}
