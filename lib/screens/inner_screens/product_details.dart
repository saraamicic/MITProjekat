import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/models/product_model.dart';
import 'package:glossyprojekat/widgets/subtitle_text.dart';
import 'package:glossyprojekat/widgets/title_text.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routName = "/ProductDetailsScreen";
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ovde uzmemo one podatke koje smo poslali klikom na karticu
    final productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detaljnije o proizvodu",
          style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.w600, 
          ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitelesTextWidget(
                        label: productModel.title,
                        fontSize: 24,
                        maxLines: 5,
                      ),
                      const SizedBox(
                        height: 10,
                      ), // Razmak između naslova i cene
                      SubtitleTextWidget(
                        label: "${productModel.price} RSD",
                        color: const Color.fromARGB(255, 226, 143, 171),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),
                  const TitelesTextWidget(label: "O proizvodu"),
                  const SizedBox(height: 10),
                  SubtitleTextWidget(
                    //opis
                    label: productModel.description,
                  ),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),

      //dugme za dodavanje u korpu
      bottomSheet: SizedBox(
        width: double.infinity,
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 208, 139, 162),
            ),
            onPressed: () {},
            icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
            label: const Text(
              "Dodaj u korpu",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
