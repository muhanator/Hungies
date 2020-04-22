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
  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  int booleanFlag = 0;

  List currentRestaurant = restaurantImages;
  List selectedRestaurant = [];
  void initState() {
    super.initState();

    _buttonController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    rotate = Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceInOut,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          var i = currentRestaurant.removeLast();
          currentRestaurant.insert(0, i);

          _buttonController.reset();
        }
      });
    });

    right = Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceInOut,
      ),
    );
    bottom = Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceInOut,
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
      currentRestaurant.remove(img);
    });
  }

  addImg(DecorationImage img) {
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
    _swipeAnimation();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Map()));
  }

  swipeLeft() {
    if (booleanFlag == 1)
      setState(() {
        booleanFlag = 0;
      });
    _swipeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;

    double initialBottom = 15.0;
    var dataLength = currentRestaurant.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = -10.0;
    return Scaffold(
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
            GestureDetector(
              onTap: () {},
              child: Container(
                  margin: const EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.account_circle,
                    color: PRIMARY_COLOR,
                    size: 30.0,
                  )),
            ),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Hungies",
                style: TextStyle(
                    fontSize: 20,
                    color: PRIMARY_COLOR,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        body: Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: dataLength > 0
              ? Stack(
                  alignment: AlignmentDirectional.center,
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
                          onResize: () {
                          },
                          onDismissed: (DismissDirection direction) {
                            if (direction == DismissDirection.endToStart) {
                              dismissImg(item);
                            }
                            else {
                              addImg(item);
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
                                tag: "img",
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          DetailPage(type: item),
                                    ));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
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
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: screenSize.width / 1.2 +
                                                backCardWidth +
                                                10,
                                            height: screenSize.height / 2.2,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                      Radius.circular(8.0)),
                                              image: item,
                                            ),
                                          ),
                                          Container(
                                              width: screenSize.width / 1.2 +
                                                  backCardWidth +
                                                  10,
                                              height: screenSize.height / 1.7 -
                                                  screenSize.height / 2.2,
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  FlatButton(
                                                      onPressed: () {
                                                        swipeLeft();
                                                      },
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
                                                            Icons.thumb_down,
                                                            color: Colors.red,
                                                          ))),
                                                  FlatButton(
                                                      onPressed: () {
                                                        swipeRight();
                                                      },
                                                      child: Container(
                                                        height: 60,
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
                                                          Icons.thumb_up,
                                                          color: PRIMARY_COLOR,
                                                        ),
                                                      ))
                                                ],
                                              ))
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.transparent,
                          elevation: 4.0,
                          child: new Container(
                            alignment: Alignment.center,
                            width: screenSize.width / 1.2 + backCardWidth,
                            height: screenSize.height / 1.7,
                            decoration: new BoxDecoration(
                              color: CARD_GREY,
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: screenSize.width / 1.2 + backCardWidth,
                                  height: screenSize.height / 2.2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        topRight: Radius.circular(8.0)),
                                    image: item,
                                  ),
                                ),
                                Container(
                                    width:
                                        screenSize.width / 1.2 + backCardWidth,
                                    height: screenSize.height / 1.7 -
                                        screenSize.height / 2.2,
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        FlatButton(
                                            padding: EdgeInsets.all(0.0),
                                            onPressed: () {},
                                            child: Container(
                                                height: 60.0,
                                                width: 80,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: CARD_GREY,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          60.0),
                                                ),
                                                child: Icon(
                                                  Icons.thumb_down,
                                                  color: Colors.red,
                                                ))),
                                        FlatButton(
                                            padding: EdgeInsets.all(0.0),
                                            onPressed: () {},
                                            child: Container(
                                              height: 60,
                                              width: 80,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: CARD_GREY,
                                                borderRadius:
                                                    BorderRadius.circular(60.0),
                                              ),
                                              child: Icon(
                                                Icons.thumb_up,
                                                color: PRIMARY_COLOR,
                                              ),
                                            ))
                                      ],
                                    ))
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
