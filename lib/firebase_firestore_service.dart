import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
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

}

