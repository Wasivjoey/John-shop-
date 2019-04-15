import 'dart:async';

import 'package:flutter/material.dart';
import 'package:john_shop_mob/pages/product_details.dart';
import 'package:john_shop_mob/firebase_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:john_shop_mob/struct/product.dart';
import 'package:john_shop_mob/Model.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  static final model = Model();


  List<Product> product_list;
  StreamSubscription<QuerySnapshot> productSub;

  @override
  void initState() {
    super.initState();

    product_list = new List();

    productSub?.cancel();
    productSub = db.getProducts().listen((QuerySnapshot snapshot) {
      final List<Product> prodList = snapshot.documents
          .map((documentSnapshot) => Product.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.product_list = prodList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: product_list.length,
    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index){
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Single_prod(
            product_name: '${product_list[index].productName}',
            product_picture: '${product_list[index].productPicture}',
            product_price: '${product_list[index].productPrice}',
          ),
        );
      });
  }

  /*Stream<QuerySnapshot> getProducts({int offset, int limit}) {
    model.getProduc
  }*/
}

  class Single_prod extends StatelessWidget {
    final product_name;
    final product_picture;
    final product_price;


    Single_prod({
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
                  child: Image.network(
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
  