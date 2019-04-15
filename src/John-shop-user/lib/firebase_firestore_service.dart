import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:john_shop_mob/struct/cart.dart';
import 'package:john_shop_mob/struct/order.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

final CollectionReference orderCollection = Firestore.instance.collection('order');
final CollectionReference cartCollection = Firestore.instance.collection('cart');
final CollectionReference productCollection = Firestore.instance.collection('products');
final CollectionReference localCollection = Firestore.instance.collection('location');
Geoflutterfire geo = Geoflutterfire();
var location = new Location();

class FirebaseFirestoreService {

  static final FirebaseFirestoreService _instance = new FirebaseFirestoreService.internal();

  factory FirebaseFirestoreService()=> _instance;

  FirebaseFirestoreService.internal();

  Future<Order> createOrder(String name, String price, String quantity, String studId, String studName) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(orderCollection.document());

      final Order order = new Order(studId, studName, name, price, quantity);
      final Map<String, dynamic> data = order.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Order.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Future<Cart> addToCart(String name, String price, String quantity, String picture) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(cartCollection.document());

      final Cart cart = new Cart(ds.documentID, name, price, quantity, picture);
      final Map<String, dynamic> data = cart.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Cart.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getCart({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = cartCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Stream<QuerySnapshot> getProducts({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = productCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Future<dynamic> emptyCart(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(cartCollection.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<DocumentReference> addGeoPoint(String studId, String studName) async {
    var pos = await location.getLocation();
    GeoFirePoint point = geo.point(latitude: pos['latitude'], longitude: pos['longitude']);
    return localCollection.add({
      'position': point.data,
      'id': studId,
      'name': studName
    });
  }
}

