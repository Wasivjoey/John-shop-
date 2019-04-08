import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:john_shop_mob/pages/cartProduct.dart';
import 'package:john_shop_mob/firebase_firestore_service.dart';
import 'package:john_shop_mob/struct/cart.dart';


class Cart_Page extends StatefulWidget {
  @override
  _Cart_PageState createState() => _Cart_PageState();
}

class _Cart_PageState extends State<Cart_Page> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  List<Cart> cart_List;
  int total = 0;
  StreamSubscription<QuerySnapshot> productSub;
  String stud = '0';


  @override
  void initState() {
    super.initState();

    cart_List = new List();

    productSub?.cancel();
    productSub = db.getCart().listen((QuerySnapshot snapshot) {
      final List<Cart> cartList = snapshot.documents
          .map((documentSnapshot) => Cart.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.cart_List = cartList;
        int loop  = cart_List.length;
        for (var index = 0; index < loop ;index++) {
          total = int.parse('${cart_List[index].productPrice}') + total;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        title: Text("Cart"),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search, color: Colors.white,), onPressed: () {

          }),

        ],
      ),

      body: new Cart_products(),

      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
                child: ListTile(
                  title: new Text("Total"),
                  subtitle: new Text("\$$total"),
                )),
            Expanded(
              child: new MaterialButton(
                onPressed: () {
                  stud = '1507146';
                  var loop = cart_List.length;
                  for (var index = 0; index < loop ;index++) {
                    db.createOrder('${cart_List[index].productName}','${cart_List[index].productPrice}','${cart_List[index].productQuantity}',stud);
                    db.emptyCart('${cart_List[index].id}');
                  }
                  db.addGeoPoint(stud);
                },
                child: new Text(
                  "Check out", style: TextStyle(color: Colors.white),
                ),
                color: Colors.green,
              ),

            )
          ],),
      ),
    );
  }
}

