import 'package:flutter/material.dart';

class CartModels with ChangeNotifier {
  final String id, productid;
  final int quantity;

  CartModels(
      {required this.id, required this.productid, required this.quantity});
}
