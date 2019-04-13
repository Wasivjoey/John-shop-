import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:john_shop_mob/pages/cartProduct.dart';
import 'package:john_shop_mob/firebase_firestore_service.dart';
import 'package:john_shop_mob/struct/cart.dart';
import 'package:john_shop_mob/model.dart';
import 'package:john_shop_mob/struct/order.dart';



class Cart_Page extends StatefulWidget {
  @override
  _Cart_PageState createState() => _Cart_PageState();
}

class _Cart_PageState extends State<Cart_Page> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  static final model = Model();
  List<Cart> cart_List;
  int total = 0;
  StreamSubscription<QuerySnapshot> productSub;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _studIdController = TextEditingController();
  TextEditingController _studNameController = TextEditingController();
  String _studId = '';
  String _studName = '';
  var stud;


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
          total = (int.parse('${cart_List[index].productPrice}') * int.parse('${cart_List[index].productQuantity}')) + total;
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
                  showDialog(context: context,
                  builder: (context){
                    return new AlertDialog(
                      title: new Text("Enter details for delivery"),
                      content: new Form(
                        key: _formKey,
                        child: FormUI(),
                      ),
                    );
                  }
                  );
                  //stud = '1507146';

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

  Widget FormUI() {
    return new Column(
      children: <Widget>[
        new TextFormField(
          controller: _studNameController,
          onSaved: (v) => _studName = v,
          decoration: const InputDecoration(
            labelText: 'Name',
            hintText: 'Enter your full name'
          ),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value.isEmpty) {
            return 'Please enter your name';
            }
          }
        ),
        new TextFormField(
          controller: _studIdController,
          onSaved: (v) => _studId = v,
          decoration: const InputDecoration(
            labelText: 'Student Id',
            hintText: 'Enter your student id'
          ),
          keyboardType: TextInputType.number,
          validator: numberValidator,
        ),
        new RaisedButton(
        onPressed: (){
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            var loop = cart_List.length;
            for (var index = 0; index < loop; index++) {
              createOrder('${cart_List[index].productName}',
                  '${cart_List[index].productPrice}',
                  '${cart_List[index].productQuantity}', _studId, _studName);
              emptyCart('${cart_List[index].id}');
            }
            addGeoPoint(_studId, _studName);
            Navigator.of(context).pop(context);
          }
        },
        child: new Text('Confirm'),
        ),
        new RaisedButton(
          onPressed: (){
            Navigator.of(context).pop(context);
          },
          child: new Text('Cancel'),
        ),

      ],
    );
  }

  String numberValidator(String value) {
    final n = num.tryParse(value);
    if(value.length != 7) {
    return 'Id numbers are 7 numbers in length';
    } else if(n == null) {
    return '"$value" is not a valid number';
    }
    return null;
    }

  void createOrder(String name, String price, String quantity, String studId, String studName) async {
    await model.createOrder(name, price, quantity, studId, studName);
  }

  Future emptyCart(String id) async{
    await model.emptyCart(id);
  }

  Future<DocumentReference> addGeoPoint(String studId, String studName) async {
    await model.addGeoPoint(studId, studName);
  }
}





