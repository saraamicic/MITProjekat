import 'package:flutter/material.dart';

//model za porudzbine

class OrderModel with ChangeNotifier {
  final String orderId;
  final String userId; 
  final String userName;
  final String address;
  final double totalPrice;
  final List products; // Lista ID-eva 
  final DateTime orderDate;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.userName,
    required this.address,
    required this.totalPrice,
    required this.products,
    required this.orderDate,
  });
}