
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/widgets/title_text.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = "/OrdersScreen";
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitelesTextWidget(label: "Moje Porudžbine"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("orders").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Greška prilikom učitavanja"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Još uvek nemate porudžbina"));
          }

          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              // uzimamo podatke iz jednog dokumenta
              var orderData = snapshot.data!.docs[index];
              
              DateTime date = (orderData['orderDate'] as Timestamp).toDate();
              String formattedDate = DateFormat('dd.MM.yyyy HH:mm').format(date);

              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.receipt_long, color: Colors.pink),
                ),
                title: Text("Porudžbina: #${orderData['orderId'].toString().substring(0, 8)}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Datum: $formattedDate"),
                    Text("Adresa: ${orderData['address']}"),
                  ],
                ),
                trailing: Text(
                  "${orderData['totalPrice']} RSD",
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),
                ),
              );
            },
          );
        },
      ),
    );
  }
}