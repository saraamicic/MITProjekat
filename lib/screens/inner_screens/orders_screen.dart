import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:flutter/material.dart';
import 'package:glossyprojekat/widgets/title_text.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = "/OrdersScreen";
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const TitelesTextWidget(label: "Moje Porudžbine"),
        backgroundColor: const Color.fromARGB(255, 253, 235, 236),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where('userId', isEqualTo: user?.uid)
            .orderBy('orderDate', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.pink));
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Greška prilikom učitavanja"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("Još uvek nemate porudžbina", style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              var orderData = snapshot.data!.docs[index];
              
              DateTime date = (orderData['orderDate'] as Timestamp).toDate();
              String formattedDate = DateFormat('dd.MM.yyyy HH:mm').format(date);

              return Card( 
                elevation: 0.5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 253, 235, 236),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.receipt_long, color: Colors.pink),
                  ),
                  title: Text(
                    "Porudžbina: #${orderData['orderId'].toString().substring(0, 8)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text("Datum: $formattedDate"),
                      Text("Dostava na: ${orderData['userAddress'] ?? orderData['address']}"),
                    ],
                  ),
                  trailing: Text(
                    "${orderData['totalPrice']} RSD",
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}