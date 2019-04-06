import 'package:flutter/material.dart';
import 'package:john_shop_mob/cartProduct.dart';
import 'package:john_shop_mob/firebase_firestore_service.dart';


class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();

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
                  subtitle: new Text("\$500"),
                )),
            Expanded(
              child: new MaterialButton(
                onPressed: () {  },
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

