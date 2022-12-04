
import 'package:apiintegration/styled/themedata.dart';
import 'package:apiintegration/ui/homepage/homepage.dart';
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
      theme: themedata,
      home: HomePage(),
    );
  }
}