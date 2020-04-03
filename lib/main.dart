import 'package:flutter/material.dart';
import 'package:hungies/views/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hungies',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
