import 'package:flutter/material.dart';
import 'package:glossyprojekat/screens/cart/bottom_checkout.dart';
import 'package:glossyprojekat/widgets/cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const CartBottomWidget(),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
         
        ),
        title: const Text("Glossy Korpa"), // naslov
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_forever_rounded, color: Colors.pink),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5, // pet puta isti widget
        itemBuilder: (context, index) {
          return const CartWidget();
        },
      ),
    );
  }
}
