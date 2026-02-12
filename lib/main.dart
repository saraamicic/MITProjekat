import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/consts/app_colors.dart';
import 'package:glossyprojekat/providers/cart_provider.dart';
import 'package:glossyprojekat/providers/navigation_provider.dart';
import 'package:glossyprojekat/providers/orders_provider.dart';
import 'package:glossyprojekat/providers/products_provider.dart';
import 'package:glossyprojekat/providers/wishlist_provider.dart';
import 'package:glossyprojekat/screens/admin/admin_dashboard_screen.dart';
import 'package:glossyprojekat/screens/admin/edit_product_screen.dart';
import 'package:glossyprojekat/screens/inner_screens/checkout_screen.dart';
import 'package:glossyprojekat/screens/inner_screens/orders_screen.dart';
import 'package:glossyprojekat/screens/inner_screens/product_details.dart';
import 'package:glossyprojekat/screens/inner_screens/register_screen.dart';
import 'package:glossyprojekat/screens/inner_screens/sub_category_screen.dart';
import 'package:glossyprojekat/screens/profile/login_screen.dart';
import 'package:glossyprojekat/screens/profile/wishlist_screen.dart';
import 'package:glossyprojekat/screens/main_screens/root_screen.dart';
import 'package:glossyprojekat/screens/main_screens/search_screen.dart';
import 'package:glossyprojekat/screens/profile/user_profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC0Bte0oNATwB2fWNnNhZ5mhdJVzzzm1As",
      appId: "1:202764777668:android:977834bf9c20070b5d7191",
      messagingSenderId: "202764777668",
      projectId: "glossyprojekat",
      storageBucket: "glossyprojekat.firebasestorage.app",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
      ],
      child: MaterialApp(
        title: 'Glossy',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffoldBackground,
          textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 253, 235, 236),
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 22, 
              fontWeight: FontWeight.w900,
            ),
            iconTheme: IconThemeData(color: Colors.black),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.glossyPink,
            primary: AppColors.glossyPink,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            }

            if (!snapshot.hasData) {
              return const RootScreen();
            }

            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(snapshot.data!.uid)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(body: Center(child: CircularProgressIndicator()));
                }

                if (userSnapshot.hasData && userSnapshot.data!.exists) {
                  final data = userSnapshot.data!.data() as Map<String, dynamic>?;
                  if (data != null && data['isAdmin'] == true) {
                    return const AdminDashboardScreen();
                  }
                }
                return const RootScreen();
              },
            );
          },
        ),
        routes: {
          RootScreen.routeName: (context) => const RootScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          ProductDetailsScreen.routName: (context) => const ProductDetailsScreen(),
          SubCategoryScreen.routeName: (context) => const SubCategoryScreen(),
          SearchScreen.routeName: (context) => const SearchScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          UserProfileScreen.routeName: (context) => const UserProfileScreen(),
          WishlistScreen.routeName: (context) => WishlistScreen(),
          CheckoutScreen.routeName: (context) => const CheckoutScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
          AdminDashboardScreen.routeName: (context) => const AdminDashboardScreen(),
          EditProductScreen.routeName: (context) => const EditProductScreen(),
        },
      ),
    );
  }
}