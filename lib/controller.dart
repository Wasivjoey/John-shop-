import 'dart:async';
import 'package:john_shop_mob/struct/cart.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'firebase_firestore_service.dart';
import 'package:john_shop_mob/Model.dart';


class Con extends ControllerMVC {
  factory Con() {
    if (_this == null) _this = Con._();
    return _this;
  }
  static Con _this;

  Con._();
  static Con get con => _this;

  static final model = Model();


  Future addtoCart(String name, String price, String quantity, String picture) async{
    print("success");
    var load = await model.db.addToCart(name, price, quantity, picture);

    return load;
  }

}