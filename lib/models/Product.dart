import 'package:flutter/foundation.dart';

class Product {
  String name;
  String image;
  String description;
  double price;
  DateTime manufacturingDate;
  String ownerId;
  String category;

  Product(
      {required this.name,
      required this.image,
      required this.category,
      required this.description,
      required this.ownerId,
      required this.price,
      required this.manufacturingDate});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'manufacturingDate': manufacturingDate,
      'ownerId': ownerId,
      'category': category,
    };
  }

  Product fromJSon(json) {
    return Product(
        name: json['name'],
        image: json['image'],
        category: json['category'],
        description: json['description'],
        ownerId: json['ownerId'],
        price: json['price'],
        manufacturingDate: json['manufacturingDate']);
  }
}
