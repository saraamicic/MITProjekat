import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/models/product_model.dart';
import 'package:glossyprojekat/providers/wishlist_provider.dart';
import 'package:glossyprojekat/screens/inner_screens/product_details.dart';
import 'package:glossyprojekat/widgets/subtitle_text.dart';
import 'package:glossyprojekat/widgets/title_text.dart';
import 'package:provider/provider.dart'; 

class ProductWidget extends StatelessWidget {
  final ProductModel productModel;
  
  const ProductWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    // dodala provajder
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    Size size = MediaQuery.of(context).size;
    
    return GestureDetector(
      onTap: () {
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitelesTextWidget(
                    label: productModel.title,
                    fontSize: 14,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: SubtitleTextWidget(
                          label: "${productModel.price} RSD",
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 226, 143, 171),
                        ),
                      ),
                      // srculence
                      IconButton(
                        onPressed: () {
                          wishlistProvider.addOrRemoveFromWishlist(
                            productId: productModel.id,
                          );
                        },
                        icon: Icon(
                          wishlistProvider.isProductInWishlist(
                                  productId: productModel.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: wishlistProvider.isProductInWishlist(
                                  productId: productModel.id)
                              ? Colors.red
                              : Colors.grey,
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