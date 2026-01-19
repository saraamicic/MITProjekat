import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/models/product_model.dart';
import 'package:glossyprojekat/screens/inner_screens/product_details.dart';
import 'package:glossyprojekat/widgets/subtitle_text.dart';
import 'package:glossyprojekat/widgets/title_text.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel productModel;
  const ProductWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        // Navigacija na detalje proizvoda
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.routName,
          arguments: productModel,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // slika
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
              child: FancyShimmerImage(
                imageUrl: productModel.image,
                height: size.height * 0.2, // koliko slika zauzima na kartici
                width: double.infinity,
                boxFit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            
            // naslov
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TitelesTextWidget(
                label: productModel.title,
                fontSize: 15,
                maxLines: 2, // Ograničeno na dva reda da ne kvari grid
              ),
            ),
            
            const Spacer(), //opet ono da cena bude dole
            
            // cena i ikonica
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 5,
                    child: SubtitleTextWidget(
                      label: "${productModel.price} RSD",
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 226, 143, 171),
                    ),
                  ),
                  // Mala ikonica za dodavanje (vizuelno popunjava prostor)
                  Flexible(
                    child: Icon(
                      Icons.add_shopping_cart,
                      size: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}