import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:john_shop_mob/order.dart';
import 'package:john_shop_mob/firebase_firestore_service.dart';

 class Cart_products extends StatefulWidget {
   @override
   _Cart_productsState createState() => _Cart_productsState();
 }
 
 class _Cart_productsState extends State<Cart_products> {
   FirebaseFirestoreService db = new FirebaseFirestoreService();

   List<Order> items;
   StreamSubscription<QuerySnapshot> cartSub;

   @override
   void initState() {
     super.initState();

     items = new List();

     cartSub?.cancel();
     cartSub = db.getCart().listen((QuerySnapshot snapshot) {
       final List<Order> cart_stuff = snapshot.documents
           .map((documentSnapshot) => Order.fromMap(documentSnapshot.data))
           .toList();
       setState(() {
         this.items = cart_stuff;

       });
     });
   }

   @override
   Widget build(BuildContext context) {
     return new ListView.builder(
       itemCount:  items.length,
       itemBuilder: (context, index){
         return Single_cart_product(
           cart_product_name: '${items[index].productName}',
           cart_product_picture: '${items[index].productName}',
           cart_product_price: '${items[index].productPrice}',
           cart_product_quantity: '${items[index].productQuantity}',
         );
       

   });
   }
    }

 class Single_cart_product  extends StatelessWidget {

    final cart_product_name;
    final cart_product_picture;
    final cart_product_price;
    final cart_product_quantity;

    Single_cart_product({
       this.cart_product_name,
       this.cart_product_picture,
       this.cart_product_price,
       this.cart_product_quantity,

    });

   @override
   Widget build(BuildContext context) {
     return Card(
       child: ListTile(

         //========leading Section===========
    leading: new Image.asset(cart_product_picture, width: 80.0,height: 80.0,),

    //=======titel section ========
         title: new Text(cart_product_name),

         //=======subtitle section ========
         subtitle:  new Column(
           children: <Widget>[
             

// ++++++++++++++++ Item pice +++++++++++++++
             new Container(
               alignment: Alignment.topLeft,
               child: new Text("\$${cart_product_price}", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),)
             )
  
           ],

     ),
     trailing: new Column(
       children: <Widget>[
         new IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: (){}),
         new Text("${cart_product_quantity}"),
         new IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){}),
       ],
     ),
       ),
       );
       }
 }

