 import 'package:flutter/material.dart';

 class Cart_products extends StatefulWidget {
   @override
   _Cart_productsState createState() => _Cart_productsState();
 }
 
 class _Cart_productsState extends State<Cart_products> {
   var Products_on_Cart =[{

      "name":"Patty",
      "picture":'images/patty.jpeg',
      "price":140,
      "Quantity": 2,
    },
    {
      "name":"dog",
      "picture":'images/cats/food.png',
      "price":90,
      "Quantity": 1 , 
    },
    {
      "name":'cake ',
      "picture":'images/cats/snacks.png',
      "price":90,
       "Quantity": 4 ,
    },
    {
      "name":"juice",
      "picture":'images/cats/soda .png',
      "price":90,
       "Quantity": 7 ,
    },
   ];
   
   @override
   Widget build(BuildContext context) {
     return new ListView.builder(
       itemCount:  3,
       itemBuilder: (context, index){
         return Single_cart_product(
           cart_product_name: Products_on_Cart[index]["name"],
           cart_product_picture: Products_on_Cart[index]["picture"],
           cart_product_price: Products_on_Cart[index]["price"],
           cart_product_quantity: Products_on_Cart[index]["Quantity"],
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

