import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/models/product_model.dart';
import 'package:glossyprojekat/screens/inner_screens/product_details.dart';
import 'package:glossyprojekat/widgets/subtitle_text.dart';
import 'package:glossyprojekat/widgets/title_text.dart';


class LatestArrivalProductWidget extends StatelessWidget {
  final ProductModel productModel; 

  const LatestArrivalProductWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.routName,
          arguments: productModel, //saljemo nas proizvod
        );
      },
      child: Container( 
        width: size.width * 0.7, //za karticu
        height: size.width * 0.35,
        padding: const EdgeInsets.all(9.0), 
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor, 
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), 
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), 
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: FancyShimmerImage(
                imageUrl: productModel.image,
                width: size.width * 0.27,
                height: size.width * 0.30,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 7),
                  TitelesTextWidget(
                    label: productModel.title,
                    fontSize: 16,
                    maxLines: 3,
                  ),

                  const Spacer(),
                  SubtitleTextWidget(
                    label: " ${productModel.price} RSD",
                    color: const Color.fromARGB(255, 229, 169, 189),
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 15), // razmak od dole
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}