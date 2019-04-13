import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:john_shop_mob/struct/cart.dart';
import 'package:john_shop_mob/firebase_firestore_service.dart';
import 'package:john_shop_mob/Model.dart';

 class Cart_products extends StatefulWidget {
   @override
   _Cart_productsState createState() => _Cart_productsState();
 }
 
 class _Cart_productsState extends State<Cart_products> {
   FirebaseFirestoreService db = new FirebaseFirestoreService();

   List<Cart> items;
   StreamSubscription<QuerySnapshot> cartSub;

   @override
   void initState() {
     super.initState();

     items = new List();

     cartSub?.cancel();
     cartSub = db.getCart().listen((QuerySnapshot snapshot) {
       final List<Cart> cart_stuff = snapshot.documents
           .map((documentSnapshot) => Cart.fromMap(documentSnapshot.data))
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
           cart_product_id: '${items[index].id}',
           cart_product_name: '${items[index].productName}',
           cart_product_picture: '${items[index].productPicture}',
           cart_product_price: '${items[index].productPrice}',
           cart_product_quantity: '${items[index].productQuantity}',
         );
       

   });
   }
    }

 class Single_cart_product  extends StatelessWidget {

   FirebaseFirestoreService db = new FirebaseFirestoreService();
   static final model = Model();


   final cart_product_name;
   final cart_product_id;
    final cart_product_picture;
    final cart_product_price;
    final cart_product_quantity;

    Single_cart_product({
       this.cart_product_name,
       this.cart_product_id,
       this.cart_product_picture,
       this.cart_product_price,
       this.cart_product_quantity,

    });

   @override
   Widget build(BuildContext context) {
     return Card(
       child: ListTile(

         //========leading Section===========
    leading: new Image.network(cart_product_picture, width: 80.0,height: 80.0,),

    //=======titel section ========
         title: new Text(cart_product_name),

         //=======subtitle section ========
         subtitle:  new Column(
           children: <Widget>[
// ++++++++++++++++ Item pice +++++++++++++++
             new Container(
               alignment: Alignment.topLeft,
               child: new Text("\$${cart_product_price}", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),)
             ),
             new Container(
               alignment: Alignment.topRight,
               child: new Column(
                 children: <Widget>[
                   new Text("Quantity", textAlign: TextAlign.center, style: TextStyle(fontSize: 12),),
                   new Text("${cart_product_quantity}", textAlign: TextAlign.center, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                 ],
               ),
             )
           ],
     ),
     trailing: new Column(
       children: <Widget>[
         //new IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: (){}),
        new IconButton(icon: Icon(Icons.remove_shopping_cart), onPressed: (){
           emptyCart('${cart_product_id}');
         },),
         //new IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){}),
       ],
     ),
       ),
       );
       }

       Future<Cart> emptyCart(String id) async{
        await model.emptyCart(id);
       }
 }

