import 'package:flutter/cupertino.dart';

class ProductModels with ChangeNotifier {
  final String id, title, imageUrl, productcat,color,size,price;
  final double  salePrice;
  final bool isOnSale;

  ProductModels(
      {
        required this.size,
        required this.color,
        required this.id,
      required this.title,
      required this.imageUrl,
      required this.productcat,
      required this.price,
      required this.salePrice,
      required this.isOnSale,
});
}
