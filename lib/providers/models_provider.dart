import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/producys_models.dart';

class ProductProvider with ChangeNotifier {
  static final List<ProductModels> _products = [];
  Future<void> fetchData() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productsSnapshot) {
      for (var element in productsSnapshot.docs) {
        _products.insert(
            0,
            ProductModels(
              id: element.get('id'),
              title: element.get('title'),
              imageUrl: element.get('imageUrl'),
              productCat: element.get('productCategoryName'),
              price: element.get('price'),
              salePrice: element.get('salePrice'),
              isOnSale: element.get('isOnSale'),
              size: element.get('Size'),
              color: element.get('Color'),
            ));
      }
    });
    notifyListeners();
  }

  List<ProductModels> get getProductList {
    return _products;
  }

  List<ProductModels> get getOnSaleProducts {
    return _products.where((element) => element.isOnSale).toList();
  }

  ProductModels findProductById(String productId) {
    return _products.firstWhere((element) => element.id == productId);
  }

  List<ProductModels> findByCategory(String categoryName) {
    List<ProductModels> categoryList = _products
        .where((element) => element.productCat
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return categoryList;
  }
}
