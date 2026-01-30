import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/RegisterScreen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    //roverava validator funkcije u TextFormField-ovima
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      //kreira korisnika u firebase auth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        'userId': uid,
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'address': _addressController.text.trim(),
        'phone': _phoneController.text.trim(),
        'points': 50, 
        'createdAt': Timestamp.now(),
      });

      if (!mounted) return;

     Navigator.pop(context);
      
    } on FirebaseAuthException catch (e) {
      String poruka = "Došlo je do greške";
      if (e.code == 'email-already-in-use') poruka = "Email je već u upotrebi.";
      if (e.code == 'weak-password') poruka = "Lozinka je slaba.";
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(poruka)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 253, 235, 236),
        title: const Text("Registracija", style: TextStyle(color: Colors.black)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text("Kreirajte nalog",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _nameController,
                        decoration: _inputDeco("Ime i prezime", Icons.person),
                        validator: (v) => v!.isEmpty ? "Unesite ime" : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _inputDeco("Email adresa", Icons.email),
                        validator: (v) => !v!.contains("@") ? "Nevalidan email" : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _addressController,
                        decoration: _inputDeco("Adresa stanovanja", Icons.home),
                        validator: (v) => v!.isEmpty ? "Unesite adresu" : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: _inputDeco("Broj telefona", Icons.phone),
                        validator: (v) => v!.isEmpty ? "Unesite telefon" : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: _inputDeco("Lozinka", Icons.lock),
                        validator: (v) => v!.length < 6
                            ? "Lozinka mora imati min 6 karaktera"
                            : null,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: size.width * 0.7,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 239, 170, 193),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: _signUp,
                          child: const Text("KREIRAJ NALOG",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  InputDecoration _inputDeco(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}