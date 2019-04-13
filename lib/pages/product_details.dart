import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:john_shop_mob/controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:john_shop_mob/struct/cart.dart';
import 'package:john_shop_mob/Model.dart';


class ProductDetails extends StatefulWidget {

  final product_detail_name;
  final product_detail_price;
  final product_detail_picture;

  ProductDetails({
    this.product_detail_name,
    this.product_detail_price,
    this.product_detail_picture,
    });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends StateMVC<ProductDetails> {
  NumberPicker integerNumberPicker;
  static final model = Model();




  Future _showIntDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 10,
          initialIntegerValue: _currentQuantity,
        );
      },
    ).then((num value) {
      if (value != null) {
        setState(() => _currentQuantity = value);
        integerNumberPicker.animateInt(value);
      }
    });
  }

  int _currentQuantity = 1;

  void _showDialog() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          integerNumberPicker = new NumberPicker.integer(
            initialValue: _currentQuantity,
            minValue: 0,
            maxValue: 100,
            step: 10,
            onChanged: (value) => setState(() => _currentQuantity = value),
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        title: Text("John's Shop"),
        actions: <Widget>[
          new IconButton( icon: Icon(Icons.search, color: Colors.white,), onPressed: (){}),
          new IconButton( icon: Icon(Icons.shopping_cart, color: Colors.white,), onPressed: (){})
        ],
      ),
    body: new ListView(
      children: <Widget>[
        new Container(
          height: 300.0,
          child: GridTile(
            child: new Container(
              color: Colors.white,
              child: Image.network(widget.product_detail_picture),
            
            ),
      footer: new Container(
        color: Colors.white70,
        child: ListTile(
         leading: new Text(widget.product_detail_name,
         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
         title: new Row( 
           children: <Widget>[ 
             Expanded(
               child: new Text("\$${widget.product_detail_price}",
               style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold ),
               )
               ),
           ],
         ),
        ),
      ),
          ),
        ),
 // =============Button=================

         Row(
          children: <Widget>[

              //  ======= 2nd button size =======
            Expanded(
              child: MaterialButton(
                onPressed: ()=> _showIntDialog(),
                color:  Colors.white, textColor: Colors.grey,elevation: 0.2,
                child: Row(
                  children: <Widget>[
                    Expanded(
                       child: new Text("Quantity: $_currentQuantity")
                    ),

                    Expanded(
                      child: new Icon(Icons.arrow_drop_down)
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        // =======2nd button====

        Row(
          children: <Widget>[
            // +++++ size of button====
            Expanded(
              child: MaterialButton(onPressed: (){},
              color: Colors.green,
              textColor: Colors.white,
              elevation: 0.2,
              child: new Text("Buy now"),
              ),
            ),
         
          
           new IconButton(icon: Icon(Icons.add_shopping_cart), color: Colors.green, onPressed: (){
             //Con.bo()
            addtoCart(widget.product_detail_name,widget.product_detail_price.toString(),'$_currentQuantity'.toString(),widget.product_detail_picture)
                .then((_) {
            Navigator.pop(context);/* db.addToCart(widget.product_detail_name,widget.product_detail_price.toString(),'$_currentQuantity'.toString(),widget.product_detail_picture)
                .then((_) {
            Navigator.pop(context);*/
            });
           },)
           ],
        ),
Divider(color: Colors.green,),
new ListTile(
  title: new Text("Product Details"),
  subtitle: new Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"),
),
Divider(color: Colors.green,),
new Row(
  children: <Widget>[
    Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
    child: new Text("Product Name",style: TextStyle(color: Colors.grey,),)),
    Padding(padding: EdgeInsets.all(5.0),
    child: new Text(widget.product_detail_name),)
  ],
),

Divider(),
      ],
    ),
    );
  }


  Future<Cart> addtoCart(String name, String price, String quantity, String picture) async{
    var load = await model.addToCart(name, price, quantity, picture);
    refresh();
    return load;
  }
}


