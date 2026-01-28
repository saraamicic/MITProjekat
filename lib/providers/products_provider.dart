import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/models/product_model.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get getProducts => _products;

  // uzimamo iz firebasea proizvode
  Future<void> fetchProducts() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('products').get();
      _products = snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  ProductModel? findByProdId(String productId) {
    if (_products.any((element) => element.id == productId)) {
      return _products.firstWhere((element) => element.id == productId);
    }
    return null; 
  }
}