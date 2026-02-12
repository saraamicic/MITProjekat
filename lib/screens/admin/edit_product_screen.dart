import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:glossyprojekat/models/product_model.dart';
import 'package:glossyprojekat/providers/products_provider.dart';
import 'package:uuid/uuid.dart'; 

class EditProductScreen extends StatefulWidget {
  static const routeName = "/EditProductScreen";
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Kontroleri za polja
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();

  ProductModel? _existingProduct;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final product =
          ModalRoute.of(context)!.settings.arguments as ProductModel?;
      if (product != null) {
        _existingProduct = product;
        _titleController.text = product.title;
        _priceController.text = product.price.toString();
        _categoryController.text = product.category;
        _descriptionController.text = product.description;
        _imageUrlController.text = product.image;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final productsProvider = Provider.of<ProductsProvider>(
      context,
      listen: false,
    );

    final newProduct = ProductModel(
      id: _existingProduct?.id ?? const Uuid().v4(),
      title: _titleController.text, 
      price: double.parse(_priceController.text), 
      category: _categoryController.text,
      description: _descriptionController.text, 
      image: _imageUrlController.text, 
      quantity: 10,
    );

    try {
      if (_existingProduct != null) {
        await productsProvider.updateProduct(newProduct);
      } else {
        await productsProvider.addProduct(newProduct);
      }
      if (!mounted) return;
      Navigator.of(context).pop(); 
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Uspešno sačuvano!")));
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Greška"),
          content: Text("Došlo je do greške: $error"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _existingProduct != null ? "Izmeni proizvod" : "Dodaj proizvod",
        ),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save)),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.pink))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildInput(_titleController, "Naziv proizvoda"),
                      const SizedBox(height: 10),
                      _buildInput(
                        _priceController,
                        "Cena (RSD)",
                        type: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      _buildInput(_categoryController, "Kategorija"),
                      const SizedBox(height: 10),
                      _buildInput(_descriptionController, "Opis", maxLines: 3),
                      const SizedBox(height: 10),
                      _buildInput(_imageUrlController, "URL Slike"),
                      const SizedBox(height: 20),

                      if (_imageUrlController.text.isNotEmpty)
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                          ),
                        ),

                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _saveForm,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.pink,
                        ),
                        child: const Text(
                          "SAČUVAJ PROIZVOD",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildInput(
    TextEditingController controller,
    String label, {
    TextInputType type = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) => value!.isEmpty ? "Ovo polje je obavezno" : null,
      onChanged: (_) => setState(() {}), 
    );
  }
}
