import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/widgets.dart';
import 'package:shop_app/models/cart_models.dart';

import '../../provider/dark_theme_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/models_provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key, required this.q}) : super(key: key);
  final int q;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int counter = 0;

  @override
  void initState() {
    counter = widget.q;

    super.initState();
  }

  IconData? icon;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    final productProviders = Provider.of<ProductProvider>(context);
    final cartModelsvar = Provider.of<CartModels>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final getCurrentProduct =
        productProviders.findProductById(cartModelsvar.productid);

    int setOfThreeOfSameItem = counter ~/ 3;
    double totalDiscount = 0.0;
    double totalPrice = double.parse(getCurrentProduct.price.toString()) *
        int.parse(counter.toString());

    int discount = setOfThreeOfSameItem * int.parse(getCurrentProduct.price);
    totalDiscount = totalPrice - discount;

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.maxFinite,
        height: 200,
        decoration: BoxDecoration(
          color: themeState.getDarkTheme
              ? const Color(0xFF335171)
              : const Color(0xff0ececec),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "ProductDetScreen",
                    arguments: cartModelsvar.productid);
              },
              child: Container(
                width: 110,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(getCurrentProduct.imageUrl),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  text: getCurrentProduct.title,
                  size: 20,
                  textfontWeight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 10,
                ),
                _quantityControler(
                  color: const Color(0xFFececec),
                  function1: () {
                    cartProvider.reduceCartByOne(getCurrentProduct.id);
                    setState(() {
                      if (counter <= 1) {
                      } else {
                        counter--;
                      }
                    });
                  },
                  function2: () {
                    cartProvider.increaseCartByOne(getCurrentProduct.id);

                    setState(() {
                      if (counter >= 99) {
                      } else {
                        counter++;
                      }
                    });
                  },
                  icon1: Icons.remove,
                  icon2: Icons.add,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    ReusableText(
                      text: 'Total: ',
                      textfontWeight: FontWeight.bold,
                    ),
                    ReusableText(
                      text: 'iq ${totalDiscount.toStringAsFixed(2)}',
                      size: 20,
                      textfontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFececec),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      cartProvider.removeOneItem(getCurrentProduct.id);
                    },
                    icon: const Icon(Icons.remove_shopping_cart_rounded),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quantityControler({
    required Color color,
    required Function() function1,
    required Function() function2,
    required IconData icon1,
    required IconData icon2,
  }) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return SizedBox(
      width: 150,
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              width: 130,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        function1();
                      },
                      icon: Icon(
                        icon1,
                        color: themeState.getDarkTheme
                            ? const Color(0xFF335171)
                            : const Color(0xFF001B36),
                      )),
                  Text(
                    counter.toString(),
                    style: TextStyle(
                        color: themeState.getDarkTheme
                            ? const Color(0xFF335171)
                            : const Color(0xFF001B36),
                        fontSize: 25),
                  ),
                  IconButton(
                    onPressed: () {
                      function2();
                    },
                    icon: Icon(
                      icon2,
                      color: themeState.getDarkTheme
                          ? const Color(0xFF335171)
                          : const Color(0xFF001B36),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
