import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String id, title, category, description, image;
  final double price; 
  final int quantity; 
  final bool isBestseller;
  final bool isNew;

  ProductModel({
    required this.id,
    required this.title,
    this.price = 0.0, 
    required this.category,
    required this.description,
    required this.image,
    this.quantity = 1, 
    this.isBestseller = false,
    this.isNew = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'category': category,
      'description': description,
      'image': image,
      'quantity': quantity,
      'isBestseller': isBestseller,
      'isNew': isNew,
    };
  }

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      title: data['title'] ?? '',
      price: double.parse((data['price'] ?? 0.0).toString()),
      image: data['image'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      quantity: int.parse((data['quantity'] ?? 0).toString()),
      isBestseller: data['isBestseller'] ?? false,
      isNew: data['isNew'] ?? false,
    );
  }
}