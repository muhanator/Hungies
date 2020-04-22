import 'package:flutter/material.dart';
import 'package:hungies/constants.dart';
import 'package:hungies/data.dart';

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
        primaryColor: Colors.black,
        platform: Theme.of(context).platform,
      ),
      child:  Container(
        width: width.value,
        height: heigth.value,
        color: Colors.black,
        child: new Hero(
          tag: "img",
          child: new Card(
            color: Colors.transparent,
            child:  Container(
              alignment: Alignment.center,
              width: width.value,
              height: heigth.value,
              decoration:  BoxDecoration(
                borderRadius:  BorderRadius.circular(20.0),
              ),
              child:  Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                   CustomScrollView(
                    slivers: <Widget>[
                       SliverAppBar(
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
                          SizedBox(height: 10),
                          Container(
                            color: Colors.black,
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                 Container(
                                   decoration:  BoxDecoration(
                                       borderRadius:  BorderRadius.circular(20.0),
                                       color: CARD_GREY),
                                  padding:  const EdgeInsets.all(15),
                                  alignment: Alignment.center,
                                  child:  Column(
                                    children: <Widget>[
                                      Text(
                                        "INFO",
                                        style:  TextStyle(color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            color: PRIMARY_COLOR,
                                          ),
                                          SizedBox(width: 10),
                                          Flexible(
                                            child: Text("1657 Saint-Catherine St W, Montreal, Quebec H3H 1L7",
                                              style:  TextStyle(color: Colors.white,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.phone,
                                            color: PRIMARY_COLOR,
                                          ),
                                          SizedBox(width: 10),
                                          Text("(514) 939-3329",
                                            style:  TextStyle(color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.access_time,
                                            color: PRIMARY_COLOR,
                                          ),
                                          SizedBox(width: 10),
                                          Text("9:00  AM - 8:00 PM",
                                              style:  TextStyle(color: Colors.white,
                                                  fontWeight: FontWeight.normal))
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.directions_walk,
                                            color: PRIMARY_COLOR,
                                          ),
                                          SizedBox(width: 10),
                                          Text("7 min (600 m)",
                                            style:  TextStyle(color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.public,
                                            color: PRIMARY_COLOR,
                                          ),
                                          SizedBox(width: 10),
                                          Text("3amigosrestaurants.com",
                                            style:  TextStyle(color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ),
                                 SizedBox(height: 10),
                                 Container(
                                   padding:  const EdgeInsets.all(15),
                                   decoration:  BoxDecoration(
                                       borderRadius:  BorderRadius.circular(20.0),
                                       color: CARD_GREY),
                                   child: Column(
                                     children: <Widget>[
                                       Text(
                                         "ABOUT",
                                         style:  TextStyle(color: Colors.white,
                                             fontWeight: FontWeight.bold),
                                       ),
                                       SizedBox(height: 10),
                                       Text(
                                           "3 amigos is a place where you may find mexican style cuisine. "
                                               "It offers fine sit-down dining as well as take-out with a variety of dessert and drinks.",
                                           style: TextStyle(color: Colors.white,
                                               fontWeight: FontWeight.normal))
                                     ],
                                   ),
                                 ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                   Container(
                      width: 600.0,
                      height: 80.0,
                      alignment: Alignment.center,
                      child: Row(
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
                                    Icons.clear,
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
                                  Icons.favorite,
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
