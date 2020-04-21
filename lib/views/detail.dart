import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hungies/constants.dart';
import 'package:hungies/data.dart';
import 'package:hungies/images.dart';

class DetailPage extends StatefulWidget {
  final DecorationImage type;
  const DetailPage({Key key, this.type}) : super(key: key);
  @override
  _DetailPageState createState() =>  _DetailPageState(type: type);
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  AnimationController _containerController;
  Animation<double> width;
  Animation<double> heigth;
  DecorationImage type;
  _DetailPageState({this.type});
  List data = restaurantImages;
  double _appBarHeight = 256.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  void initState() {
    _containerController =  AnimationController(
        duration:  Duration(milliseconds: 2000), vsync: this);
    super.initState();
    width =  Tween<double>(
      begin: 200.0,
      end: 220.0,
    ).animate(
       CurvedAnimation(
        parent: _containerController,
        curve: Curves.ease,
      ),
    );
    heigth =  Tween<double>(
      begin: 400.0,
      end: 400.0,
    ).animate(
       CurvedAnimation(
        parent: _containerController,
        curve: Curves.ease,
      ),
    );
    heigth.addListener(() {
      setState(() {
        if (heigth.isCompleted) {}
      });
    });
    _containerController.forward();
  }

  @override
  void dispose() {
    _containerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int img = data.indexOf(type);
    return  Theme(
      data:  ThemeData(
        brightness: Brightness.light,
        primaryColor: DARK_GREY,
        platform: Theme.of(context).platform,
      ),
      child:  Container(
        width: width.value,
        height: heigth.value,
        color: CARD_GREY,
        child: new Hero(
          tag: "img",
          child: new Card(
            color: Colors.transparent,
            child:  Container(
              alignment: Alignment.center,
              width: width.value,
              height: heigth.value,
              decoration:  BoxDecoration(
                color: CARD_GREY,
                borderRadius:  BorderRadius.circular(10.0),
              ),
              child:  Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                   CustomScrollView(
                    slivers: <Widget>[
                       SliverAppBar(
                        elevation: 0.0,
                        forceElevated: true,
                        leading:  IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon:  Icon(
                            Icons.arrow_back,
                            color: PRIMARY_COLOR,
                            size: 30.0,
                          ),
                        ),
                        expandedHeight: _appBarHeight,
                        pinned: _appBarBehavior == AppBarBehavior.pinned,
                        floating: _appBarBehavior == AppBarBehavior.floating ||
                            _appBarBehavior == AppBarBehavior.snapping,
                        snap: _appBarBehavior == AppBarBehavior.snapping,
                        flexibleSpace:  FlexibleSpaceBar(
                          background:  Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                               Container(
                                width: width.value,
                                height: _appBarHeight,
                                decoration:  BoxDecoration(
                                  borderRadius:  BorderRadius.circular(20.0),
                                  image: data[img],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                       SliverList(
                        delegate:  SliverChildListDelegate(<Widget>[
                           Container(
                            color: CARD_GREY,
                            child:  Padding(
                              padding: const EdgeInsets.all(35.0),
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                   Container(
                                     decoration:  BoxDecoration(
                                         color: CARD_GREY,
                                         border:  Border(
                                             bottom:  BorderSide(
                                                 color: Colors.black12))),
                                    padding:  EdgeInsets.only(bottom: 20.0),
                                    alignment: Alignment.center,
                                    child:  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                         Row(
                                          children: <Widget>[
                                             Icon(
                                              Icons.access_time,
                                              color: PRIMARY_COLOR,
                                            ),
                                             Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child:  Text("10:00  AM",
                                                  style:  TextStyle(color: Colors.white,
                                                      fontWeight: FontWeight.normal)),
                                            )
                                          ],
                                        ),
                                         Row(
                                          children: <Widget>[
                                             Icon(
                                              Icons.map,
                                              color: PRIMARY_COLOR,
                                            ),
                                             Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child:  Text("700 m",
                                                  style:  TextStyle(color: Colors.white,
                                                      fontWeight: FontWeight.normal),
                                            ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                   Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, bottom: 8.0),
                                    child:  Text(
                                      "ABOUT",
                                      style:  TextStyle(color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                   Text(
                                      "3 amigos is a place where you may find mexican style cuisine. "
                                          "It offers fine sit-down dining as well as take-out with a variety of dessert and drinks",
                                     style: TextStyle(color: Colors.white,
                                       fontWeight: FontWeight.normal)),
                                   Container(
                                    height: 100.0,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                   Container(
                      width: 600.0,
                      height: 80.0,
                      decoration:  BoxDecoration(
                        color:  CARD_GREY,
                      ),
                      alignment: Alignment.center,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
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
    );
  }
}
