import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/models/product_model.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get getProducts => _products;

  Future<void> fetchProducts() async {
    try {
      // Povlačimo sve proizvode 
      final snapshot = await FirebaseFirestore.instance.collection('products').get();
      
      _products = snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
      
      notifyListeners();
    } catch (e) {
      print("Greška pri preuzimanju proizvoda: $e");
      rethrow;
    }
  }

  ProductModel? findByProdId(String productId) {
    if (_products.isEmpty) return null;
    return _products.firstWhere((element) => element.id == productId);
  }

  Future<void> addProduct(ProductModel newProduct) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(newProduct.id)
          .set(newProduct.toMap());
      

      await fetchProducts(); 
    } catch (e) {
      print("Greška pri dodavanju proizvoda: $e");
      rethrow;
    }
  }

  Future<void> updateProduct(ProductModel editedProduct) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(editedProduct.id)
          .update(editedProduct.toMap());
          
      await fetchProducts();
    } catch (e) {
      print("Greška pri ažuriranju proizvoda: $e");
      rethrow;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await FirebaseFirestore.instance.collection('products').doc(productId).delete();
      _products.removeWhere((element) => element.id == productId);
      notifyListeners();
    } catch (e) {
      print("Greška pri brisanju proizvoda: $e");
      rethrow;
    }
  }
}