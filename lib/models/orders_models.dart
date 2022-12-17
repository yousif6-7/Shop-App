import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersModel with ChangeNotifier {
  final String orderId,phoneNumber, userId, productId, userName, orderprice, orderimageUrl, quantity,address,productName;
  final Timestamp orderDate;

  OrdersModel(   {
    required this.phoneNumber,
    required this.productName,
    required this.address,
    required this.orderId,
    required this.userId,
    required this.productId,
    required this.userName,
    required this.orderprice,
    required this.orderimageUrl,
    required this.quantity,
    required this.orderDate,
  });
}
