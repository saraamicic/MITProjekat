import 'package:flutter/material.dart';
import 'package:glossyprojekat/providers/cart_provider.dart'; 
import 'package:glossyprojekat/screens/cart/bottom_checkout.dart';
import 'package:glossyprojekat/widgets/cart_widget.dart';
import 'package:glossyprojekat/widgets/title_text.dart';
import 'package:provider/provider.dart'; 

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //pristupimo korpi preko providera
    final cartProvider = Provider.of<CartProvider>(context);
    
    // proverimo jel korpa prazna
    if (cartProvider.getCartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const TitelesTextWidget(label: "Korpa"), centerTitle: true),
        body: const Center(child: TitelesTextWidget(label: "Vaša korpa je prazna")),
      );
    }

    return Scaffold(
      bottomSheet: const CartBottomWidget(),
      appBar: AppBar(
        title: const TitelesTextWidget(label: "Korpa"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // obrise se sve
              cartProvider.clearCart();
            },
            icon: const Icon(Icons.delete_forever_rounded, color: Colors.pink),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight + 80),
        //gledamo koliko imamo cart itema
        itemCount: cartProvider.getCartItems.length, 
        itemBuilder: (context, index) {
          //prosleđujemo podatke o konkretnom proizvodu u CartWidget
          // Uzimamo vrednosti iz mape (CartModel stavke)
          return ChangeNotifierProvider.value(
            value: cartProvider.getCartItems.values.toList()[index],
            child: const CartWidget(),
          );
        },
      ),
    );
  }
}