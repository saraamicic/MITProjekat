import 'package:flutter/material.dart';
import 'package:glossyprojekat/screens/inner_screens/product_details.dart';
import 'package:glossyprojekat/screens/inner_screens/sub_category_screen.dart';
import 'package:glossyprojekat/screens/root_screen.dart';
import 'package:glossyprojekat/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RootScreen(),

      routes: {
        ProductDetailsScreen.routName: (context) => const ProductDetailsScreen(),
        SubCategoryScreen.routeName: (context) => const SubCategoryScreen(),
        SearchScreen.routeName: (context) => const SearchScreen(),
      },

    );
  }
}
