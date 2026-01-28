import 'package:flutter/material.dart';
import 'package:glossyprojekat/providers/products_provider.dart';
import 'package:glossyprojekat/screens/cart/cart_screen.dart';
import 'package:glossyprojekat/screens/categories_screen.dart';
import 'package:glossyprojekat/screens/home_screen.dart';
import 'package:glossyprojekat/screens/profile_screen.dart';
import 'package:glossyprojekat/screens/search_screen.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    //cim se aplikacija pokrene fetchujem podatke radi korpe
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
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          //ovo je da kad kliknem na neki od ikonica da je to onda current
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
