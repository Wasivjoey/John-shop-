import 'package:flutter/material.dart';
import 'package:john_shop_mob/order.dart';
import 'package:john_shop_mob/firebase_firestore_service.dart';


class ProductDetails extends StatefulWidget {
  final Order order;

  final product_detail_name;
  final product_detail_price;
  final product_detail_picture;

  ProductDetails({
    this.product_detail_name,
    this.product_detail_price,
    this.product_detail_picture,
    this.order
    });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();

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
         
          
           new IconButton(icon: Icon(Icons.add_shopping_cart), color: Colors.green, onPressed: (){
            db.addToCart(widget.product_detail_name,widget.product_detail_price.toString(),"edt2")
                .then((_) {
            Navigator.pop(context);
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
new Text("Similar Products"),
// Similar products 
Container(
  height: 340.0,
  child: Similar_Products(),
)
      ],
    ),
    );
  }
}
class Similar_Products extends StatefulWidget {
  @override
  _Similar_ProductsState createState() => _Similar_ProductsState();
}
class _Similar_ProductsState extends State<Similar_Products> {

 var product_list=[
    {
      "name":"Patty",
      "picture":'images/patty.jpeg',
      "price":140,
    },
    {
      "name":"dog",
      "picture":'images/cats/food.png',
      "price":90,
    },
    {
      "name":'cake ',
      "picture":'images/cats/snacks.png',
      "price":90,
    },
    {
      "name":"juice",
      "picture":'images/cats/soda .png',
      "price":90,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: product_list.length,
    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index){
        return Similar_prod(
          product_name: product_list[index]['name'],
          product_picture: product_list[index]['picture'],
          product_price: product_list[index]['price'],
        );
      });
  }
}

class Similar_prod extends StatelessWidget {
    final product_name;
    final product_picture;
    final product_price;


    Similar_prod({
    this.product_name,
    this.product_picture,
    this.product_price,
    });
    @override
    Widget build(BuildContext context) {
      return Card(
      child: Hero(
          tag: product_name,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => new ProductDetails(
                  product_detail_name:  product_name,
                  product_detail_picture: product_picture,
                  product_detail_price: product_price,
                ) )),
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                        leading: Text(
                          product_name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        title: Text(
                          "\$$product_price",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w800),
                        ),
                        
                    ),
                  ),
                  child: Image.asset(
                    product_picture,
                    fit: BoxFit.cover,
                  )
              ),
            ),
          )
        ),
    );
  }
    
  }
  