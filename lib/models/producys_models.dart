// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ProductModels extends Equatable with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final String productCat;
  final String color;
  final String size;
  final String price;
  final double salePrice;
  final bool isOnSale;

  ProductModels({
    required this.size,
    required this.color,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.productCat,
    required this.price,
    required this.salePrice,
    required this.isOnSale,
  });

  @override
  List<Object> get props => [price, salePrice, isOnSale, id, title, imageUrl];
}
