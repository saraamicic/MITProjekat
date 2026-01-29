import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:glossyprojekat/providers/wishlist_provider.dart';
import 'package:glossyprojekat/providers/products_provider.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";

  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //provajderi
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);

    // dobijemo listu iz wishlist providera
    final wishlistItemsList = wishlistProvider.getWishlistItems.values.toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Lista favorita (${wishlistItemsList.length})",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 253, 235, 236),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),

      body: wishlistItemsList.isEmpty
          ? const Center(
              child: Text(
                "Vaša lista favorita je prazna",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: wishlistItemsList.length,
                itemBuilder: (context, index) {
                  // Za svaki ID iz wishliste nadji pun model proizvoda
                  final productId = wishlistItemsList[index].productId;
                  final getProduct = productsProvider.findByProdId(productId);

                  if (getProduct == null) {
                    return const SizedBox.shrink();
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                                child: Image.network(
                                  getProduct.image, 
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // srce
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () {
                                    wishlistProvider.addOrRemoveFromWishlist(
                                        productId: getProduct.id);
                                  },
                                  child: const Icon(Icons.favorite,
                                      color: Colors.pink),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getProduct.title, 
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${getProduct.price} RSD", 
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 239, 170, 193),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}