import 'package:flutter/material.dart';
import 'package:glossyprojekat/consts/app_constants.dart';
import 'package:glossyprojekat/models/product_model.dart'; 
import 'package:glossyprojekat/widgets/products/product_widget.dart';
import 'package:glossyprojekat/widgets/title_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;
  // Dodajemo listu koja će čuvati rezultate pretrage
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
    // Ako je polje prazno, koristi sve proizvode, inače koristi filtriranu listu
    List<ProductModel> currentList = searchTextController.text.isEmpty
        ? AppConstants.products
        : productListSearch;

    return Scaffold(
      appBar: AppBar(
        title: const TitelesTextWidget(label: "Pretraži proizvode"),
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
              // ovde se zapravo pretrazuje
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
                  ? const Center(child: Text("Nema pronađenih proizvoda"))
                  : GridView.builder(
                      itemCount: currentList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Dve kolone
                        childAspectRatio: 0.6, // Odnos širine i visine kartice
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