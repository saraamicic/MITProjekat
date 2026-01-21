import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/providers/cart_provider.dart';
import 'package:glossyprojekat/providers/products_provider.dart';
import 'package:glossyprojekat/widgets/subtitle_text.dart';
import 'package:glossyprojekat/widgets/title_text.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Uzimamo podatke o stavci u korpi (iz CartScreen-a)
    final cartModel = Provider.of<CartModel>(context);
    
    //Uzimamo podatke o samom proizvodu iz glavne liste proizvoda
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProduct = productProvider.findByProdId(cartModel.productId);
    
    // Pristupamo CartProvider-u za funkcije plus/minus/brisanje
    final cartProvider = Provider.of<CartProvider>(context);

    if (getCurrentProduct == null) return const SizedBox.shrink();

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
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: FancyShimmerImage(
                  imageUrl: getCurrentProduct.image,
                  height: size.height * 0.13,
                  width: size.height * 0.13,
                  boxFit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              
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
                              label: getCurrentProduct.title,
                              fontSize: 16,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Funkcija za uklanjanje stavke iz korpe
                              cartProvider.removeOneItem(productId: cartModel.productId);
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      SubtitleTextWidget(
                        label: "${getCurrentProduct.price} RSD", 
                        color: const Color.fromARGB(255, 226, 143, 171),
                      ),
                      const SizedBox(height: 10), 
                      Row(
                        children: [
                          _quantityController(
                            icon: Icons.remove,
                            color: Colors.grey.shade300,
                            onTap: () {
                              cartProvider.updateQuantity(
                                productId: cartModel.productId, 
                                quantity: cartModel.quantity - 1
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: SubtitleTextWidget(
                              label: "${cartModel.quantity}", 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _quantityController(
                            icon: Icons.add,
                            color: const Color.fromARGB(255, 226, 143, 171),
                            onTap: () {
                              cartProvider.updateQuantity(
                                productId: cartModel.productId, 
                                quantity: cartModel.quantity + 1
                              );
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