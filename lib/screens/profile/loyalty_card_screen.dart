import 'package:flutter/material.dart';

class LoyaltyCardScreen extends StatelessWidget {
  static const routeName = "/LoyaltyCardScreen";
  const LoyaltyCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Loyalty Kartica",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20, 
            fontWeight: FontWeight.bold, 
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 253, 235, 236),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Vaš personalni QR kod",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 239, 170, 193),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=SaraMicic252',
                width: 200,
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.qr_code,
                    size: 200,
                    color: Colors.grey,
                  );
                },
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              "Ukupan broj bodova:",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Text(
              "252",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 239, 170, 193),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
