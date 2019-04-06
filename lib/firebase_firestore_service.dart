import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:john_shop_mob/order.dart';

final CollectionReference orderCollection = Firestore.instance.collection('order');
final CollectionReference cartCollection = Firestore.instance.collection('cart');
final CollectionReference productCollection = Firestore.instance.collection('products');

class FirebaseFirestoreService {

  static final FirebaseFirestoreService _instance = new FirebaseFirestoreService.internal();

  factory FirebaseFirestoreService()=> _instance;

  FirebaseFirestoreService.internal();

  Future<Order> createOrder(String name, String price, String quantity) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(orderCollection.document());

      final Order order = new Order(ds.documentID, name, price, quantity);
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

  Future<Order> addToCart(String name, String price, String quantity) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(cartCollection.document());

      final Order order = new Order(ds.documentID, name, price, quantity);
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

  Future<dynamic> updateNote(Order note) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(orderCollection.document(note.id));

      await tx.update(ds.reference, note.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> deleteOrder(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(orderCollection.document(id));

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
}
