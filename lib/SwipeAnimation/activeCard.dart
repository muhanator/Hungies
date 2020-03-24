import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hungies/SwipeAnimation/detail.dart';
import 'package:hungies/constants.dart';

Positioned cardDemo(
    DecorationImage img,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    BuildContext context,
    Function dismissImg,
    int flag,
    Function addImg,
    Function swipeRight,
    Function swipeLeft) {
  Size screenSize = MediaQuery.of(context).size;
  // print("Card");
  return  Positioned(
    bottom: 100.0 + bottom,
    right: flag == 0 ? right != 0.0 ? right : null : null,
    left: flag == 1 ? right != 0.0 ? right : null : null,
    child:  Dismissible(
      key:  Key( Random().toString()),
      crossAxisEndOffset: -0.3,
      onResize: () {
        //print("here");
        // setState(() {
        //   var i = data.removeLast();

        //   data.insert(0, i);
        // });
      },
      onDismissed: (DismissDirection direction) {
//          _swipeAnimation();
        if (direction == DismissDirection.endToStart)
          dismissImg(img);
        else
          addImg(img);
      },
      child:  Transform(
        alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
        //transform: null,
        transform:  Matrix4.skewX(skew),
        //..rotateX(-math.pi / rotation),
        child:  RotationTransition(
          turns:  AlwaysStoppedAnimation(
              flag == 0 ? rotation / 360 : -rotation / 360),
          child:  Hero(
            tag: "img",
            child:  GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //      MaterialPageRoute(
                //         builder: (context) =>  DetailPage(type: img)));
                Navigator.of(context).push( PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>  DetailPage(type: img),
                    ));
              },
              child: Card(
                color: Colors.transparent,
                elevation: 4.0,
                child: Container(
                  alignment: Alignment.center,
                  width: screenSize.width / 1.2 + cardWidth,
                  height: screenSize.height / 1.7,
                  decoration: BoxDecoration(
                    color: CARD_GREY,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child:  Column(
                    children: <Widget>[
                       Container(
                        width: screenSize.width / 1.2 + cardWidth,
                        height: screenSize.height / 2.2,
                        decoration:  BoxDecoration(
                          borderRadius:  BorderRadius.only(
                              topLeft:  Radius.circular(8.0),
                              topRight:  Radius.circular(8.0)),
                          image: img,
                        ),
                      ),
                       Container(
                          width: screenSize.width / 1.2 + cardWidth,
                          height:
                              screenSize.height / 1.7 - screenSize.height / 2.2,
                          alignment: Alignment.center,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                               FlatButton(
                                  padding:  EdgeInsets.all(0.0),
                                  onPressed: () {
                                    swipeLeft();
                                  },
                                  child:  Container(
                                    height: 60.0,
                                    width: 80,
                                    alignment: Alignment.center,
                                    decoration:  BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                           BorderRadius.circular(60.0),
                                    ),
                                    child: Icon(Icons.thumb_down)
                                  )),
                               FlatButton(
                                  padding:  EdgeInsets.all(0.0),
                                  onPressed: () {
                                    swipeRight();
                                  },
                                  child:  Container(
                                    height: 60,
                                    width: 80,
                                    alignment: Alignment.center,
                                    decoration:  BoxDecoration(
                                      color: GREEN,
                                      borderRadius:
                                           BorderRadius.circular(60.0),
                                    ),
                                    child: Icon(Icons.thumb_up),
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
}
