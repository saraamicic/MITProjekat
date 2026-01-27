import 'package:flutter/material.dart';
import 'package:glossyprojekat/providers/products_provider.dart';
import 'package:uuid/uuid.dart';

// modeluje kako izgleda jedna stavka u korpi
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
  // mapa koja čuva stavke: ključ je productId, vrednost je cartmodel
  final Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  // funkcija za dodavanje u korpu
  void addProductToCart({required String productId}) {
    if (_cartItems.containsKey(productId)) {
      // ako proizvod već postoji, samo povećaj količinu
      _cartItems.update(
        productId,
        (existingValue) => CartModel(
          cartId: existingValue.cartId,
          productId: existingValue.productId,
          quantity: existingValue.quantity + 1,
        ),
      );
    } else {
      // ako ne postoji, dodaj novi
      _cartItems.putIfAbsent(
        productId,
        () => CartModel(
          cartId: const Uuid().v4(),
          productId: productId,
          quantity: 1,
        ),
      );
    }
    notifyListeners(); // ovo javlja svim ekranima da se korpa promenila
  }

  // ukupna količina proizvoda u korpi (za ikonicu ili naslov)
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

  // Za menjanje količine
void updateQuantity({required String productId, required int quantity}) {
  if (quantity < 1) return;
  _cartItems.update(productId, (existing) => CartModel(
    cartId: existing.cartId,
    productId: productId,
    quantity: quantity,
  ));
  notifyListeners();
}
// Za brisanje jednog proizvoda iz korpe
void removeOneItem({required String productId}) {
  _cartItems.remove(productId);
  notifyListeners();
}

//fja da racuna ukupnu cenu
double getTotalAmount(ProductsProvider productsProvider) {
  double total = 0.0;
  
  _cartItems.forEach((key, value) {
    // nadjemo proizvod u products provideru preko ida
    final getProduct = productsProvider.findByProdId(value.productId);
    
    if (getProduct != null) {
      total += getProduct.price * value.quantity;
    }
  });
  
  return total;
}

}