import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Coordinates {
  double lat;
  double lng;
  String id;

  Coordinates(id, {lat, lng});

  DocumentReference reference;

  Coordinates.fromMap(Map snapshot, String id)
      : id = snapshot["id"] ?? "",
        lat = snapshot["lat"] ?? 0,
        lng = snapshot["lng"] ?? 0;

  toJson() {
    return {
      "id": id,
      "lat": lat,
      "lng": lng,
    };
  }
}

/*
class Product {
  String id;
  String price;
  String name;
  String img;

  Product({this.id, this.price, this.name,this.img});

  Product.fromMap(Map snapshot,String id) :
        id = id ?? '',
        price = snapshot['price'] ?? '',
        name = snapshot['name'] ?? '',
        img = snapshot['img'] ?? '';

  toJson() {
    return {
      "price": price,
      "name": name,
      "img": img,
    };
  }
}
*/
