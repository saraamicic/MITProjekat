import 'package:flutter/material.dart';
import 'package:glossyprojekat/screens/profile/loyalty_card_screen.dart';
import 'package:glossyprojekat/screens/profile/wishlist_screen.dart';
import 'package:glossyprojekat/screens/inner_screens/orders_screen.dart'; 

class UserProfileScreen extends StatelessWidget {
  static const routeName = "/UserProfileScreen";
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text("Moj Profil", style: TextStyle(color: Colors.black, fontSize: 22)),
        backgroundColor: const Color.fromARGB(255, 253, 235, 236),
        elevation: 0.5,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Blok za user info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 253, 235, 236),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://placedog.net/100/100',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sara Micic",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "saramicic@gmail.com",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        "Broj poena: 252",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 239, 170, 193),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            _buildProfileOption(
              icon: Icons.favorite, 
              iconColor: Colors.pink, 
              label: "Lista favorita",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WishlistScreen()),
                );
              },
            ),

            _buildProfileOption(
              icon: Icons.shopping_bag_outlined,
              iconColor: const Color.fromARGB(255, 0, 0, 0),
              label: "Moje porudžbine",
              onTap: () {
                Navigator.pushNamed(context, OrdersScreen.routeName);
              },
            ),

            _buildProfileOption(
              icon: Icons.qr_code_2,
              iconColor: Colors.black87,
              label: "Loyalty kartica",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoyaltyCardScreen(),
                  ),
                );
              },
            ),

            _buildProfileOption(
              icon: Icons.settings_outlined,
              iconColor: Colors.black87,
              label: "Podešavanja profila",
              onTap: () {},
            ),
            const SizedBox(height: 50),

            // logout
            Center(
              child: SizedBox(
                width: size.width * 0.6, 
                height: 55,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 239, 170, 193),
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shadowColor: const Color.fromARGB(255, 239, 170, 193).withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Izlogujte se",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // pomocni vidzet za ove kartice
  Widget _buildProfileOption({
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 250, 238, 239),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromARGB(255, 230, 200, 205),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            child: Row(
              children: [
                Icon(icon, size: 28, color: iconColor),
                const SizedBox(width: 20),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}