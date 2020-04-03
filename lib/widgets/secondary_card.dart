import 'package:flutter/material.dart';
import 'package:hungies/constants.dart';

Positioned SecondaryCard(
    DecorationImage img,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;
  return new Positioned(
    bottom: 100.0 + bottom,
    child: new Card(
      shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                     ),
      color: Colors.transparent,
      elevation: 4.0,
      child: new Container(
        alignment: Alignment.center,
        width: screenSize.width / 1.2 + cardWidth,
        height: screenSize.height / 1.7,
        decoration: new BoxDecoration(
          color: CARD_GREY,
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: Column(
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
                                  onPressed: () {},
                                  child:  Container(
                                    height: 60.0,
                                    width: 80,
                                    alignment: Alignment.center,
                                    decoration:  BoxDecoration(
                                      color: CARD_GREY,
                                      borderRadius:
                                           BorderRadius.circular(60.0),
                                    ),
                                    child: Icon(Icons.thumb_down, color: Colors.red,)
                                  )),
                               FlatButton(
                                  padding:  EdgeInsets.all(0.0),
                                  onPressed: () {},
                                  child: Container(
                                    height: 60,
                                    width: 80,
                                    alignment: Alignment.center,
                                    decoration:  BoxDecoration(
                                      color: CARD_GREY,
                                      borderRadius:
                                           BorderRadius.circular(60.0),
                                    ),
                                    child: Icon(Icons.thumb_up, color: GREEN,),
                                  ))
                            ],
                          ))
                    ],
                  ),
      ),
    ),
  );
}
