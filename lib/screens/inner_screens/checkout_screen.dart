import 'package:flutter/material.dart';
import 'package:glossyprojekat/providers/orders_provider.dart';
import 'package:glossyprojekat/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:glossyprojekat/providers/cart_provider.dart';
import 'package:glossyprojekat/widgets/title_text.dart';

class CheckoutScreen extends StatefulWidget {
  static const routeName = "/CheckoutScreen";
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  // Kontroleri za unos
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController(); 
  final _cardController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose(); 
    _cardController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Plaćanje"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitelesTextWidget(label: "Informacije za dostavu"),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Ime i prezime",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? "Unesite ime" : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: "Adresa dostave",
                    prefixIcon: Icon(Icons.home),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Unesite adresu" : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Broj telefona",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Unesite broj telefona" : null,
                ),
                const SizedBox(height: 30),
                const TitelesTextWidget(label: "Podaci o kartici"),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _cardController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Broj kartice (16 cifara)",
                    prefixIcon: Icon(Icons.credit_card),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.length < 16 ? "Nevalidan broj kartice" : null,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        controller: _expiryController,
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          labelText: "MM/YY",
                          hintText: "08/26",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Obavezno" : null,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        controller: _cvvController,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "CVV",
                          hintText: "123",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.length < 3 ? "Nevalidno" : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 208, 139, 162),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          final ordersProvider = Provider.of<OrdersProvider>(
                            context,
                            listen: false,
                          );
                          final productsProvider =
                              Provider.of<ProductsProvider>(
                                context,
                                listen: false,
                              );

                          await ordersProvider.uploadOrder(
                            userName: _nameController.text,
                            address: _addressController.text,
                            phone: _phoneController
                                .text, 
                            totalPrice: cartProvider.getTotalAmount(
                              productsProvider,
                            ),
                            products: cartProvider.getCartItems.values
                                .map(
                                  (item) => {
                                    'productId': item.productId,
                                    'quantity': item.quantity,
                                  },
                                )
                                .toList(),
                          );

                          if (!mounted) return;
                          _showSuccessDialog(context, cartProvider);
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Greška: $error")),
                          );
                        }
                      }
                    },
                    child: const Text(
                      "POTVRDI KUPOVINU",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, CartProvider cartProvider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text("Uspešno!"),
        content: const Text(
          "Vaša porudžbina je primljena. Hvala na poverenju!",
        ),
        actions: [
          TextButton(
            onPressed: () {
              cartProvider.clearCart();
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text("U redu"),
          ),
        ],
      ),
    );
  }
}
