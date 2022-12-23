import 'package:flutter/material.dart';
import 'package:shop_app/consts/widgets.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {Key? key,
      required this.saleprice,
      required this.price,
      required this.textprice,
      required this.isonsale})
      : super(key: key);
  final double saleprice, price;
  final String textprice;
  final bool isonsale;

  @override
  Widget build(BuildContext context) {
    double userPrice = isonsale ? saleprice : price;
    return FittedBox(
      child: Column(
        children: [
          ReusableText(
            text: '\$${(userPrice * int.parse(textprice)).toStringAsFixed(2)} ',
            size: 18,
            textfontWeight: FontWeight.w500,
          ),
          Visibility(
            visible: isonsale ? true : false,
            child: Text(
              '\$${(price * int.parse(textprice)).toStringAsFixed(2)}',
              style: TextStyle(decoration: TextDecoration.lineThrough),
            ),
          ),
        ],
      ),
    );
  }
}
