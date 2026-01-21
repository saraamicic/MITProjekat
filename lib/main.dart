import 'package:flutter/material.dart';
import 'package:glossyprojekat/consts/app_colors.dart';
import 'package:glossyprojekat/screens/inner_screens/product_details.dart';
import 'package:glossyprojekat/screens/inner_screens/sub_category_screen.dart';
import 'package:glossyprojekat/screens/root_screen.dart';
import 'package:glossyprojekat/screens/search_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glossy',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 253, 235, 236),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 26,
            fontWeight: FontWeight.w900, 
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.glossyPink,
          primary: AppColors.glossyPink,
          secondary:  Color.fromARGB(255, 253, 235, 236),
        ),
      ),
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
