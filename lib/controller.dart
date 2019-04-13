import 'dart:async';
import 'package:john_shop_mob/struct/cart.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
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


  Future<Cart> addtoCart(String name, String price, String quantity, String picture) async{
    var load = await model.addToCart(name, price, quantity, picture);
    refresh();
    return load;
  }

}