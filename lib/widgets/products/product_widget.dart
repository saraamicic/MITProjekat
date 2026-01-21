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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15.0),
              ),
              child: FancyShimmerImage(
                imageUrl: productModel.image,
                height: size.height * 0.20,
                width: double.infinity,
                boxFit: BoxFit.cover,
              ),
            ),
            //dole su mi naslov cena i srce
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 2.0, bottom: 8.0, top: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: TitelesTextWidget(
                      label: productModel.title,
                      fontSize: 14,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Red sa cenom i srcem
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: SubtitleTextWidget(
                            label: "${productModel.price} RSD",
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 226, 143, 171),
                          ),
                        ),
                      ),

                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            // wishlist logika 
                          },
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.pink,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
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