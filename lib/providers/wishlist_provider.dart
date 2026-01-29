import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class WishlistModel with ChangeNotifier {
  final String id;
  final String productId;

  WishlistModel({required this.id, required this.productId});
}

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getWishlistItems => _wishlistItems;

  // dodaje ili uklanja
  void addOrRemoveFromWishlist({required String productId}) {
    if (_wishlistItems.containsKey(productId)) {
      _wishlistItems.remove(productId); // ako je vec tu onda unheart
    } else {
      _wishlistItems.putIfAbsent(
        productId,
        () => WishlistModel(id: const Uuid().v4(), productId: productId),
      );
    }
    notifyListeners();
  }

  bool isProductInWishlist({required String productId}) {
    return _wishlistItems.containsKey(productId);
  }

  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}