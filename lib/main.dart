import 'package:flutter/material.dart';
import 'package:instrument_directory/splash_screen.dart';
import 'package:flutter/cupertino.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
