import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:hungies/widgets/map.dart';
import 'package:hungies/constants.dart';
import '../data.dart';
import 'detail.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  int booleanFlag = 0;

  List currentRestaurant = restaurantImages;
  List selectedRestaurant = [];
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    rotate = Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          var i = currentRestaurant.removeLast();
          currentRestaurant.insert(0, i);

          controller.reset();
        }
      });
    });

    right = Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );
    bottom = Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<Null> swipeAnimation() async {
    try {
      await controller.forward();
    } on TickerCanceled {}
  }

  dismissImage(DecorationImage img) {
    setState(() {
      currentRestaurant.remove(img);
    });
  }

  addImage(DecorationImage img) {
    setState(() {
      currentRestaurant.remove(img);
      selectedRestaurant.add(img);
    });
  }

  swipeRight() {
    if (booleanFlag == 0)
      setState(() {
        booleanFlag = 1;
      });
    swipeAnimation();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Map()));
  }

  swipeLeft() {
    if (booleanFlag == 1)
      setState(() {
        booleanFlag = 0;
      });
    swipeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    double initialBottom = 15.0;
    var dataLength = currentRestaurant.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = -10.0;
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.black,
          centerTitle: true,
          leading: Container(
            margin: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.message,
              color: PRIMARY_COLOR,
              size: 25.0,
            ),
          ),
          actions: <Widget>[
            Container(
                margin: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.account_circle,
                  color: PRIMARY_COLOR,
                  size: 30.0,
                )),
          ],
          title: Text(
            "Hungies",
            style: TextStyle(
                fontSize: 20,
                color: PRIMARY_COLOR,
                letterSpacing: 2,
                fontWeight: FontWeight.bold),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.black,
            width: 600.0,
            height: 80.0,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: swipeLeft,
                    child: Container(
                        height: 60.0,
                        width: 80,
                        alignment:
                        Alignment.center,
                        decoration:
                        BoxDecoration(
                          color: CARD_GREY,
                          borderRadius:
                          BorderRadius
                              .circular(
                              60.0),
                        ),
                        child: Icon(
                          Icons.clear,
                          color: Colors.red,
                        ))),
                FlatButton(
                  onPressed: swipeRight,
                    child: Container(
                      height: 60,
                      width: 80,
                      alignment: Alignment.center,
                      decoration:
                      BoxDecoration(
                        color: CARD_GREY,
                        borderRadius:
                        BorderRadius
                            .circular(
                            60.0),
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: PRIMARY_COLOR,
                      ),
                    ))
              ],
            )),
        body: Container(
          color: Colors.black,
          child: dataLength > 0
              ? Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: currentRestaurant.map((item) {
                    if (currentRestaurant.indexOf(item) == dataLength - 1) {
                      Size screenSize = MediaQuery.of(context).size;
                      return Positioned(
                        bottom: 100.0 + bottom.value,
                        right: booleanFlag == 0
                            ? right.value != 0.0 ? right.value : null
                            : null,
                        left: booleanFlag == 1
                            ? right.value != 0.0 ? right.value : null
                            : null,
                        child: Dismissible(
                          key: Key(Random().toString()),
                          crossAxisEndOffset: -0.3,
                          onDismissed: (DismissDirection direction) {
                            if (direction == DismissDirection.endToStart) {
                              dismissImage(item);
                            }
                            else {
                              addImage(item);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Map()));
                            }
                          },
                          child: Transform(
                            alignment: booleanFlag == 0
                                ? Alignment.bottomRight
                                : Alignment.bottomLeft,
                            transform:
                                Matrix4.skewX(rotate.value < -10 ? 0.1 : 0.0),
                            child: RotationTransition(
                              turns: AlwaysStoppedAnimation(booleanFlag == 0
                                  ? rotate.value / 360
                                  : -rotate.value / 360),
                              child: Hero(
                                tag: "image",
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          DetailPage(type: item),
                                    ));
                                  },
                                  child: Card(
                                    color: Colors.transparent,
                                    elevation: 4.0,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: screenSize.width / 1.2 +
                                          backCardWidth +
                                          10,
                                      height: screenSize.height / 1.7,
                                      decoration: BoxDecoration(
                                        color: CARD_GREY,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: screenSize.width / 1.2 +
                                                backCardWidth +
                                                10,
                                            height: screenSize.height / 2.2,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20.0),
                                              image: item,
                                            ),
                                          ),
                                          Container(
                                            padding:  const EdgeInsets.all(15),
                                            decoration:  BoxDecoration(
                                                borderRadius:  BorderRadius.circular(20.0),
                                                color: CARD_GREY),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  "About",
                                                  style:  TextStyle(color: Colors.white,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                    "Mexican style restaurant.",
                                                    style: TextStyle(color: Colors.white,
                                                        fontWeight: FontWeight.normal))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      backCardPosition = backCardPosition - 10;
                      backCardWidth = backCardWidth + 10;
                      Size screenSize = MediaQuery.of(context).size;
                      return new Positioned(
                        bottom: 100.0 + backCardPosition,
                        child: new Card(
                          color: Colors.transparent,
                          elevation: 4.0,
                          child: new Container(
                            alignment: Alignment.center,
                            width: screenSize.width / 1.2 + backCardWidth,
                            height: screenSize.height / 1.7,
                            decoration: new BoxDecoration(
                              color: CARD_GREY,
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: screenSize.width / 1.2 + backCardWidth,
                                  height: screenSize.height / 2.2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    image: item,
                                  ),
                                ),
                                Container(
                                  padding:  const EdgeInsets.all(15),
                                  decoration:  BoxDecoration(
                                      borderRadius:  BorderRadius.circular(20.0),
                                      color: CARD_GREY),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "About",
                                        style:  TextStyle(color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                          "Mexican style restaurant.",
                                          style: TextStyle(color: Colors.white,
                                              fontWeight: FontWeight.normal))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }).toList())
              : Text("No restaurants left in to area",
                  style: TextStyle(color: Colors.white, fontSize: 50.0)),
        ));
  }
}
