import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  List<ProductModel> allProducts = []; // sve iz baze
  List<ProductModel> filteredList = []; // ono sto prikazemo
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController();
    fetchProducts(); // cim se ekran otvori uzimamo podatke
  }


  Future<void> fetchProducts() async {final snapshot = await FirebaseFirestore.instance.collection('products').get();
  
  // uzmemo sve iz baze
  allProducts = snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
  
  // gledamo jel prosledjena neka kategorija
  final passedCategory = ModalRoute.of(context)!.settings.arguments as String?;

  setState(() {
    if (passedCategory != null) {
      // ako imamo kategoriju prema njoj filtriramo
      filteredList = allProducts
          .where((element) => element.category.toLowerCase() == passedCategory.toLowerCase())
          .toList();
    } else {
      // Ako nema kategorije (direkt preko searcha smo), prikazi sve
      filteredList = allProducts;
    }
    isLoading = false;
  });
  }

  void _runFilter(String query, String? category) {
    List<ProductModel> results = [];
    
    // ako postoji kategorija prvo po njoj
    results = allProducts;
    if (category != null) {
      results = results.where((p) => p.category == category).toList();
    }

    // onda ono sto korisnik kuca
    if (query.isNotEmpty) {
      results = results
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredList = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final passedCategory = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: TitelesTextWidget(label: passedCategory ?? "Pretraži proizvode"),
      ),
      body: isLoading 
        ? const Center(child: CircularProgressIndicator()) 
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: searchTextController,
                  onChanged: (value) => _runFilter(value, passedCategory),
                  decoration: InputDecoration(
                    hintText: "Pretraga...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: filteredList.isEmpty 
                    ? const Center(child: Text("Nema rezultata"))
                    : GridView.builder(
                        itemCount: filteredList.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return ProductWidget(productModel: filteredList[index]);
                        },
                      ),
                ),
              ],
            ),
          ),
    );
  }
}