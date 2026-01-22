import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";

  // hardkodovano za sad
  final List<Map<String, String>> products = [
    {
      "name": "NIVEA Hydra micelarna voda za čiscenje lica 400ml",
      "price": "399.99 RSD",
      "image":
          "https://www.lilly.rs/media/catalog/product/cache/03c23669960748ef434dcc1e546afaa9/9/0/9005800344546_1.jpg",
    },
    {
      "name": "NIVEA Šampon za suvo pranje za svetlu kosu 200m",
      "price": "779.99 RSD",
      "image":
          "https://www.lilly.rs/media/catalog/product/cache/03c23669960748ef434dcc1e546afaa9/9/0/9005800301532_1.jpg",
    },
    {
      "name":
          "Catrice Blushin' Charm Stick rumenilo i hajlajter 010 Pink Sweetheart",
      "price": "999.99 RSD",
      "image":
          "https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/4/0/4059729514899.jpg",
    },
    {
      "name": "Sabrina Carpenter Caramel Dream ženski parfem edp 30ml",
      "price": "3.999,99 RSD",
      "image":
          "https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/8/1/810023675679-01.jpg",
    },
    {
      "name": "Catrice it's easy tatoo vodootporni ajlajner 010",
      "price": "419,99 RSD  ",
      "image":
          "https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/1/0/103716_0.jpg",
    },
    {
      "name": "Byphasse mleko za skidanje šminke 500ml",
      "price": "309,99 RSD",
      "image":
          "https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/8/4/8436097095643.jpg",
    },
  ];

  WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Lista favorita",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 253, 235, 236),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //dve kol
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
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
                            product['image']!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // ikonica srculenca u uglu
                        const Positioned(
                          top: 8,
                          right: 8,
                          child: Icon(Icons.favorite, color: Colors.pink),
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
                          product['name']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product['price']!,
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
