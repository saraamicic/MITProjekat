import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool _isLoading = false;

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cardController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      if (doc.exists) {
        setState(() {
          _nameController.text = doc.get('name') ?? "";
          _addressController.text = doc.get('address') ?? "";
          _phoneController.text = doc.get('phone') ?? "";
        });
      }
    }
  }

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
    final productsProvider = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Plaćanje"), centerTitle: true),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.pink))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitelesTextWidget(label: "Informacije za dostavu"),
                      const SizedBox(height: 20),
                      _buildTextField(
                        _nameController,
                        "Ime i prezime",
                        Icons.person,
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        _addressController,
                        "Adresa dostave",
                        Icons.home,
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        _phoneController,
                        "Broj telefona",
                        Icons.phone,
                        type: TextInputType.phone,
                      ),
                      const SizedBox(height: 30),
                      const TitelesTextWidget(label: "Podaci o kartici"),
                      const SizedBox(height: 20),

                      // Broj kartice
                      _buildTextField(
                        _cardController,
                        "Broj kartice",
                        Icons.credit_card,
                        type: TextInputType.number,
                        formatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                          CardNumberInputFormatter(),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          // Datum isteka
                          Flexible(
                            child: _buildTextField(
                              _expiryController,
                              "MM/YY",
                              null,
                              hint: "08/26",
                              type: TextInputType.number,
                              formatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                                DateInputFormatter(),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          // CVV ograničen na 3 cifre
                          Flexible(
                            child: _buildTextField(
                              _cvvController,
                              "CVV",
                              null,
                              hint: "123",
                              obscure: true,
                              type: TextInputType.number,
                              formatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
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
                            backgroundColor: const Color.fromARGB(
                              255,
                              208,
                              139,
                              162,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => _isLoading = true);
                              try {
                                await cartProvider.placeOrder(
                                  productsProvider: productsProvider,
                                );
                                if (!mounted) return;
                                _showSuccessDialog(context);
                              } catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Greška: $error")),
                                );
                              } finally {
                                setState(() => _isLoading = false);
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

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData? icon, {
    TextInputType type = TextInputType.text,
    String? hint,
    bool obscure = false,
    List<TextInputFormatter>? formatters,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: obscure,
      inputFormatters: formatters,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Obavezno polje";
        if (controller == _cardController &&
            value.replaceAll(' ', '').length < 16) {
          return "Nevalidan broj kartice";
        }
        if (controller == _expiryController && value.length < 5) {
          return "Nevalidan datum";
        }
        return null;
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: const Text(
          "Vaša porudžbina je primljena! Osvojili ste poene za vernost.",
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
              },
              child: const Text(
                "Sjajno!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// formater za datum
class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) return newValue;

    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

// formater za br kartice
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(' ', '');
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
