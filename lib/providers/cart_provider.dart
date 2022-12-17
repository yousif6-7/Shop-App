import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/cart_models.dart';

import '../consts/firebase_const.dart';

class CartProvider with ChangeNotifier {
  final userCollection = FirebaseFirestore.instance.collection('users');

  Map<String, CartModels> _cartItems = {};

  Map<String, CartModels> get getCartItems {
    return _cartItems;
  }

  void addProductToCart({required String productid, required int quantity}) {
    _cartItems.putIfAbsent(
      productid,
          () => CartModels(
        id: DateTime.now().toString(),
        productid: productid,
        quantity: quantity,
      ),
    );
    notifyListeners();
  }

  void reduceCartByOne(String productId) {
    _cartItems.update(
      productId,
          (value) => CartModels(
        id: DateTime.now().toString(),
        productid: productId,
        quantity: value.quantity - 1,
      ),
    );
    notifyListeners();
  }
  void increaseCartByOne(String productId) {
    _cartItems.update(
      productId,
          (value) => CartModels(
        id: DateTime.now().toString(),
        productid: productId,
        quantity: value.quantity + 1,
      ),
    );
    notifyListeners();
  }

  void removeOneItem(String productId ){
    _cartItems.remove(productId);
    notifyListeners();
  }
  Future<void> clearDbCart()async{
    final User? user = authInstance.currentUser;

    await userCollection.doc(user!.uid).update({
      'user_cart':[],
    });
    _cartItems.clear();
    notifyListeners();
  }
  void clearCart( ){
    _cartItems.clear();
    notifyListeners();
  }
}
