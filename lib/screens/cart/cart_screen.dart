import 'package:flutter/material.dart';
import 'package:glossyprojekat/screens/cart/bottom_checkout.dart';
import 'package:glossyprojekat/widgets/cart_widget.dart';
import 'package:glossyprojekat/widgets/title_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const CartBottomWidget(),
       appBar: AppBar(
        title: const TitelesTextWidget(label: "Korpa"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_forever_rounded, color: Colors.pink),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight + 40),
        itemCount: 5, // pet puta isti widget
        itemBuilder: (context, index) {
          return const CartWidget();
        },
      ),
    );
  }
}
