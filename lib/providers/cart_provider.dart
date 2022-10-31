import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/cart_models.dart';

class CartProvider with ChangeNotifier {
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
  void clearCart( ){
    _cartItems.clear();
    notifyListeners();
  }
}
