import 'package:covid_tracker/stats.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corona Virus Tracker',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Statspage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
