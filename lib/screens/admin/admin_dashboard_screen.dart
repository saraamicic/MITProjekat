// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/screens/admin/edit_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:glossyprojekat/providers/products_provider.dart';
import 'package:glossyprojekat/models/product_model.dart';

class AdminDashboardScreen extends StatefulWidget {
  static const routeName = "/AdminDashboardScreen";
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final allProducts = productsProvider.getProducts;

    List<ProductModel> displayList = _searchController.text.isEmpty
        ? allProducts
        : allProducts
            .where((p) => p.title.toLowerCase().contains(_searchController.text.toLowerCase()))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel", style: TextStyle(fontSize: 20)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, EditProductScreen.routeName),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Pretraži proizvode...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          Expanded(
            child: displayList.isEmpty
                ? const Center(child: Text("Nema pronađenih proizvoda."))
                : ListView.builder(
                    itemCount: displayList.length,
                    itemBuilder: (ctx, i) {
                      final prod = displayList[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        child: ListTile(
                          leading: Image.network(prod.image, width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(prod.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text("${prod.price} RSD"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => Navigator.pushNamed(
                                  context, EditProductScreen.routeName, arguments: prod),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _confirmDelete(context, productsProvider, prod),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, ProductsProvider provider, ProductModel product) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Brisanje"),
        content: Text("Obrisati ${product.title}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Ne")),
          TextButton(
            onPressed: () async {
              await provider.deleteProduct(product.id);
              if (mounted) Navigator.pop(ctx);
            },
            child: const Text("DA", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}