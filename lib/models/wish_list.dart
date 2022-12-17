import 'package:flutter/material.dart';

class WishListModels with ChangeNotifier {
  final String id, productid;

  WishListModels({
    required this.id,
    required this.productid,
  });
}
