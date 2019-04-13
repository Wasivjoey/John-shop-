import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:john_shop_mob/pages/horizontal_list_view.dart';
import 'package:john_shop_mob/pages/product_page.dart';
import 'package:john_shop_mob/pages/cart_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends AppMVC {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
