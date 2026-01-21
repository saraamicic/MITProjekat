import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/widgets/subtitle_text.dart';
import 'package:glossyprojekat/widgets/title_text.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // slika proizvoda
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: FancyShimmerImage(
                  imageUrl:
                      "https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/3/6/3600522840114.jpg",
                  height: size.height * 0.13,
                  width: size.height * 0.13,
                  boxFit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              // detalji proizvoda
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TitelesTextWidget(
                              label: "Glossy Ruž za usne ",
                              fontSize: 16,
                              maxLines: 3,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SubtitleTextWidget(
                        label: "1200 RSD",
                        color: Color.fromARGB(255, 226, 143, 171),
                      ),
                      const SizedBox(height: 10),
                      // plus minus 
                      Row(
                        children: [
                          _quantityController(
                            icon: Icons.remove,
                            color: Colors.grey.shade300,
                            onTap: () {
                              // smanji kol
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: SubtitleTextWidget(
                              label: "1", // ovde će biti broj
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _quantityController(
                            icon: Icons.add,
                            color: const Color.fromARGB(255, 226, 143, 171),
                            onTap: () {
                              // povecaj kol
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // pomocni vidzet za plus minut kontrolice
  Widget _quantityController({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
}
