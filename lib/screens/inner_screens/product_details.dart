import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/models/product_model.dart';
import 'package:glossyprojekat/providers/cart_provider.dart';
import 'package:glossyprojekat/widgets/subtitle_text.dart';
import 'package:glossyprojekat/widgets/title_text.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routName = "/ProductDetailsScreen";
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detaljnije o proizvodu",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Velika slika
            FancyShimmerImage(
              imageUrl: productModel.image,
              height: size.height * 0.4,
              width: double.infinity,
              boxFit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //naslov
                  TitelesTextWidget(
                    label: productModel.title,
                    fontSize: 22,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 15),
                  //cena i srce
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubtitleTextWidget(
                        label: "${productModel.price} RSD",
                        color: const Color.fromARGB(255, 226, 143, 171),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 226, 143, 171,).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            // wishlist logika
                          },
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.pink,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),
                  const TitelesTextWidget(label: "O proizvodu"),
                  const SizedBox(height: 10),
                  SubtitleTextWidget(label: productModel.description),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),

      // Dugme za dodavanje u korpu
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 0.5),
          ),
        ),
        width: double.infinity,
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 208, 139, 162),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              
              final cartProvider = Provider.of<CartProvider>(
                context,
                listen: false,
              );
              cartProvider.addProductToCart(productId: productModel.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color.fromARGB(255,226,143,171,), 
                  behavior: SnackBarBehavior.floating, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  content: const Text(
                    "Proizvod je dodat u korpu!",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
            label: const Text(
              "Dodaj u korpu",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
