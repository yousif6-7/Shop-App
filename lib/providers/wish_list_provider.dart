import 'package:flutter/material.dart';

import '../models/wish_list.dart';

class WishListProvider with ChangeNotifier {
  final Map<String, WishListModels> _wishListItems = {};

  Map<String, WishListModels> get getwishListItems {
    return _wishListItems;
  }

  void addAndRemoveProdToWishList({required String productId}) {
    if (_wishListItems.containsKey(productId)) {
      removeOneItem(productId);
    } else {
      _wishListItems.putIfAbsent(
        productId,
        () =>
            WishListModels(id: DateTime.now().toString(), productid: productId),
      );
      notifyListeners();
    }
  }

  void removeOneItem(String productId) {
    _wishListItems.remove(productId);
    notifyListeners();
  }

  void clearWishList() {
    _wishListItems.clear();
    notifyListeners();
  }
}
