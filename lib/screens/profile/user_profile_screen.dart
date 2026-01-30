import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/screens/inner_screens/orders_screen.dart';
import 'package:glossyprojekat/screens/profile/wishlist_screen.dart';
import 'package:glossyprojekat/screens/profile/loyalty_card_screen.dart'; 

class UserProfileScreen extends StatelessWidget {
  static const routeName = "/UserProfileScreen";
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: Text("Niste ulogovani.")));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Moj Profil", style: TextStyle(color: Colors.black)),
        backgroundColor: const Color.fromARGB(255, 253, 235, 236),
        elevation: 0.5,
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.pink),
            );
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Greška pri učitavanju podataka"));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("Podaci o korisniku ne postoje."));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 253, 235, 236),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 40, color: Colors.pink),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData['name'] ?? "Korisnik",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              userData['email'] ?? "",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Poeni: ${userData['points'] ?? 0}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 239, 170, 193),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                _buildProfileOption(
                  icon: Icons.favorite_border,
                  iconColor: Colors.pink,
                  label: "Lista favorita",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WishlistScreen(),
                      ),
                    );
                  },
                ),

                _buildProfileOption(
                  icon: Icons.shopping_bag_outlined,
                  iconColor: Colors.brown,
                  label: "Moje porudžbine",
                  onTap: () =>
                      Navigator.pushNamed(context, OrdersScreen.routeName),
                ),

                _buildProfileOption(
                  icon: Icons.qr_code_scanner,
                  iconColor: Colors.deepPurple,
                  label: "Moja Loyalty Kartica",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoyaltyCardScreen(
                          name: userData['name'] ?? "Korisnik",
                          uid: user.uid,
                          points: userData['points'] ?? 0,
                        ),
                      ),
                    );
                  },
                ),

                _buildProfileOption(
                  icon: Icons.edit_outlined,
                  iconColor: Colors.blue,
                  label: "Izmeni profil",
                  onTap: () => _showEditProfileDialog(context, userData),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 239, 170, 193),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    child: const Text(
                      "IZLOGUJTE SE",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showEditProfileDialog(
    BuildContext context,
    Map<String, dynamic> userData,
  ) {
    final nameController = TextEditingController(text: userData['name']);
    final addressController = TextEditingController(text: userData['address']);
    final phoneController = TextEditingController(text: userData['phone']);
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Izmeni podatke",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Ime i prezime",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? "Polje je obavezno" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: "Adresa stanovanja",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: "Broj telefona",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final uid = FirebaseAuth.instance.currentUser!.uid;
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(uid)
                        .update({
                          'name': nameController.text.trim(),
                          'address': addressController.text.trim(),
                          'phone': phoneController.text.trim(),
                        });
                    if (context.mounted) Navigator.pop(context);
                  }
                },
                child: const Text(
                  "SAČUVAJ IZMENE",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // vidzeti za stavke 
  Widget _buildProfileOption({
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 250, 238, 239),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromARGB(255, 230, 200, 205),
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            child: Row(
              children: [
                Icon(icon, size: 26, color: iconColor),
                const SizedBox(width: 20),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
