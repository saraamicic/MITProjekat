import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/models/order_model.dart';
import 'package:uuid/uuid.dart';

class OrdersProvider with ChangeNotifier {
  final List<OrderModel> _orders = [];
  List<OrderModel> get getOrders => _orders;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadOrder({
    required String userName,
    required String address,
    required String phone, 
    required double totalPrice,
    required List products,
  }) async {
    final orderId = const Uuid().v4();
    try {
      await _firestore.collection("orders").doc(orderId).set({
        'orderId': orderId,
        'userId': 'User1', 
        'userName': userName,
        'address': address,
        'phone': phone, 
        'totalPrice': totalPrice,
        'products': products,
        'orderDate': Timestamp.now(),
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  //funkcija koja u profilu fetchuje porudzbine iz firebase-a
  Future<void> fetchOrders() async {
    try {
      final snapshot = await _firestore.collection("orders").get();
      _orders.clear();
      // ignore: unused_local_variable
      for (var doc in snapshot.docs) {
        
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}