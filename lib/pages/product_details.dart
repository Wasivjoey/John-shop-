import 'package:flutter/material.dart';

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

class _ProductDetailsState extends State<ProductDetails> {
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
              child: Image.asset(widget.product_detail_picture),
            
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
                onPressed: (){
                  showDialog(context: context,
                  builder: (context){
                    return new AlertDialog(
                      title: new Text("Quantiy"),
                      content: new Text("Choose the Quantity"),
                      actions: <Widget>[
                        new MaterialButton(
                          onPressed: (){
                            Navigator.of(context).pop(context);
                          },
                          child: new Text("Close"),
                        )
                      ],
                    );
                  });
                }, color:  Colors.white, textColor: Colors.grey,elevation: 0.2,
                child: Row(
                  children: <Widget>[
                    Expanded(
                       child: new Text("Quantity")
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
         
          
           new IconButton(icon: Icon(Icons.add_shopping_cart), color: Colors.green, onPressed: (){},)
           ],
        ),
Divider(color: Colors.green,),
new ListTile(
  title: new Text("Product Details"),
  subtitle: new Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"),
)
      ],
    ),
    );
  }
}