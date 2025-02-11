import 'package:currency_converter/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Open Exchange',
      theme: ThemeData(
        fontFamily: 'DMSans',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        primaryColor: Colors.pink,
      ),
      home: Home(),
    );
  }
}
