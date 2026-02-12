import 'package:flutter/material.dart';
import 'package:glossyprojekat/providers/navigation_provider.dart';
import 'package:glossyprojekat/providers/products_provider.dart';
import 'package:glossyprojekat/screens/cart/cart_screen.dart';
import 'package:glossyprojekat/screens/main_screens/categories_screen.dart';
import 'package:glossyprojekat/screens/main_screens/home_screen.dart';
import 'package:glossyprojekat/screens/main_screens/profile_screen.dart';
import 'package:glossyprojekat/screens/main_screens/search_screen.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  static const routeName = "/RootScreen";

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      try {
        await Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
      } catch (error) {
        print("Greška pri učitavanju proizvoda: $error");
      }
    });
  }

  final List<Widget> screens = const [
    HomeScreen(),
    SearchScreen(),
    CategoriesScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    
    return Scaffold(
      body: screens[navProvider.selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: navProvider.selectedIndex,
        onDestinationSelected: (index) => navProvider.setIndex(index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.category), label: 'Categories'),
          NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}