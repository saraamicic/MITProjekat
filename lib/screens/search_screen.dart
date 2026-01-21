import 'package:flutter/material.dart';
import 'package:glossyprojekat/consts/app_constants.dart';
import 'package:glossyprojekat/models/product_model.dart'; 
import 'package:glossyprojekat/widgets/products/product_widget.dart';
import 'package:glossyprojekat/widgets/title_text.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/SearchScreen"; 
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;
  List<ProductModel> productListSearch = [];

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // kategorije ako je poslata
    final passedCategory = ModalRoute.of(context)!.settings.arguments as String?;

    // za određivanje koju listu prikazujemo
    List<ProductModel> currentList = AppConstants.products;

    if (searchTextController.text.isNotEmpty) {
      // Ako korisnik kuca u pretragu, koristi listu za pretragu
      currentList = productListSearch;
    } else if (passedCategory != null) {
      // Ako je polje za kucanje prazno, ali imamo kategoriju, filtriraj po njoj
      currentList = AppConstants.products
          .where((element) => element.category == passedCategory)
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
       //ili pise naslov ili pretraga
        title: TitelesTextWidget(
          label: passedCategory ?? "Pretraži proizvode",
         
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // TextField polje za kucanje
            TextField(
              controller: searchTextController,
              decoration: InputDecoration(
                hintText: "Pretraga...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      searchTextController.clear();
                      FocusScope.of(context).unfocus();
                    });
                  },
                  icon: const Icon(Icons.clear,
                      color: Color.fromARGB(255, 120, 32, 24)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  productListSearch = AppConstants.products
                      .where((element) => element.title
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
            const SizedBox(height: 15),

            // GridView mreža proizvoda
            Expanded(
              child: currentList.isEmpty 
                  ? Center(
                      child: Text(
                        passedCategory != null 
                        ? "Trenutno nemamo proizvoda u kategoriji: $passedCategory"
                        : "Nema pronađenih proizvoda",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                  : GridView.builder(
                      itemCount: currentList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, 
                        childAspectRatio: 0.6, 
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return ProductWidget(
                          productModel: currentList[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}