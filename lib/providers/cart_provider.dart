import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/providers/products_provider.dart';
import 'package:uuid/uuid.dart';

// Model stavke u korpi
class CartModel with ChangeNotifier {
  final String cartId;
  final String productId;
  int quantity;

  CartModel({
    required this.cartId,
    required this.productId,
    required this.quantity,
  });
}

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  void addProductToCart({required String productId}) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (existingValue) => CartModel(
          cartId: existingValue.cartId,
          productId: existingValue.productId,
          quantity: existingValue.quantity + 1,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartModel(
          cartId: const Uuid().v4(),
          productId: productId,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  int get getCartQuantity {
    int total = 0;
    _cartItems.forEach((key, value) {
      total += value.quantity;
    });
    return total;
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void updateQuantity({required String productId, required int quantity}) {
    if (quantity < 1) return;
    _cartItems.update(
      productId,
      (existing) => CartModel(
        cartId: existing.cartId,
        productId: productId,
        quantity: quantity,
      ),
    );
    notifyListeners();
  }

  void removeOneItem({required String productId}) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  double getTotalAmount(ProductsProvider productsProvider) {
    double total = 0.0;
    _cartItems.forEach((key, value) {
      final getProduct = productsProvider.findByProdId(value.productId);
      if (getProduct != null) {
        total += getProduct.price * value.quantity;
      }
    });
    return total;
  }

  Future<void> placeOrder({required ProductsProvider productsProvider}) async {
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;
    final User? user = auth.currentUser;

    if (user == null) throw Exception("Morate biti ulogovani!");

    try {
      //povuci podatke o korisniku iz users kolekcije
      DocumentSnapshot userDoc = await firestore.collection("users").doc(user.uid).get();
      if (!userDoc.exists) throw Exception("Podaci o korisniku nisu pronađeni!");
      
      final userData = userDoc.data() as Map<String, dynamic>;

      // pripremi listu proizvoda za bazu
      List itemsList = [];
      _cartItems.forEach((key, value) {
        final currentProd = productsProvider.findByProdId(value.productId);
        if (currentProd != null) {
          itemsList.add({
            'productId': value.productId,
            'title': currentProd.title,
            'price': currentProd.price,
            'quantity': value.quantity,
          });
        }
      });

      double total = getTotalAmount(productsProvider);
      int pointsToEarn = (total * 0.1).toInt(); // 10% od ukupne cene u poene

      // upis u "orders" kolekciju
      await firestore.collection("orders").add({
        'orderId': const Uuid().v4(),
        'userId': user.uid,
        'userName': userData['name'],
        'userAddress': userData['address'],
        'userPhone': userData['phone'],
        'items': itemsList,
        'totalPrice': total,
        'orderDate': Timestamp.now(),
      });

      // dodaj poene korisniku (Loyalty sistem)
      await firestore.collection("users").doc(user.uid).update({
        'points': FieldValue.increment(pointsToEarn),
      });

      clearCart();
    } catch (e) {
      rethrow;
    }
  }
}