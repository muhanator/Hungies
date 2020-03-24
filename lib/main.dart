import 'package:flutter/material.dart';
import 'package:hungies/SwipeAnimation/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hungies',
      // showPerformanceOverlay: true,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      // home: new PageMain(),
      home: HomePage(),
      //home: BottomNavigationDemo(),
      // home:new exp(),
    );
  }
}
