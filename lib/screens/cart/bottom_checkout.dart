import 'package:flutter/material.dart';
import 'package:glossyprojekat/providers/cart_provider.dart';
import 'package:glossyprojekat/providers/products_provider.dart';
import 'package:glossyprojekat/widgets/subtitle_text.dart';
import 'package:glossyprojekat/widgets/title_text.dart';
import 'package:provider/provider.dart';

class CartBottomWidget extends StatelessWidget {
  const CartBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Pristupamo provajderima
    final cartProvider = Provider.of<CartProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(width: 1, color: Color.fromARGB(255, 249, 218, 219)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: kBottomNavigationBarHeight + 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: TitelesTextWidget(
                        label: "Ukupno (${cartProvider.getCartItems.length} proizvoda)",
                      ),
                    ),
                    SubtitleTextWidget(
                      //fja da izracuna ukupnu cenu
                      label: "${cartProvider.getTotalAmount(productsProvider).toStringAsFixed(2)} RSD",
                      color: const Color.fromARGB(255, 226, 143, 171),
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 226, 143, 171),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Kupi"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}