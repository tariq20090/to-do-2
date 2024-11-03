import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:list2/home_screen.dart';
import 'package:list2/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily To-Do List',
       debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Update this line
    );
  }
}

