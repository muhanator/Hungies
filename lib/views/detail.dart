import 'package:flutter/material.dart';
import 'package:hungies/constants.dart';
import 'package:hungies/data.dart';

class DetailPage extends StatefulWidget {
  final DecorationImage type;
  DetailPage({this.type});
  @override
  _DetailPageState createState() =>  _DetailPageState(type: type);
}

class _DetailPageState extends State<DetailPage> {
  DecorationImage type;
  _DetailPageState({this.type});
  List data = restaurantImages;
  double _appBarHeight = 256.0;

  @override
  Widget build(BuildContext context) {
    int img = data.indexOf(type);
    return  Theme(
      data:  ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
      ),
      child:  Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Card(
            color: Colors.transparent,
            child:  Container(
              alignment: Alignment.center,
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
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
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
            )),
      ),
    );
  }
}
