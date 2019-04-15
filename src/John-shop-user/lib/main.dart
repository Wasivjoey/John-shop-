import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends AppMVC {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
