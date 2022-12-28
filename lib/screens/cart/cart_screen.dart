import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/widgets.dart';
import 'package:shop_app/consts/widgets/cart_empty.dart';
import 'package:shop_app/services/methods.dart';

import '../../provider/dark_theme_provider.dart';
import '../../providers/cart_provider.dart';
import 'cart_widget.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList =
        cartProvider.getCartItems.values.toList().reversed.toList();
    return cartItemsList.isEmpty
        ? const EmptyScreen(
            imagepath: 'assets/images/clips/cart.png',
            title: 'Whoops',
            subtitle: 'Your cart is empty for now ',
            text: 'Start shopping now',
          )
        : Scaffold(
            appBar: AppBar(
              title: ReusibleText(
                text: 'Cart(${cartItemsList.length})',
                size: 20,
                textfontWeight: FontWeight.bold,
              ),
              centerTitle: false,
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        Methods.warningDialog(
                          title: "Clear ?",
                          subtitle: "Do you want to  clear your cart ?",
                          function: () {
                            cartProvider.clearCart();
                          },
                          context: context,
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            '\$Check out',
                            style: TextStyle(
                                color: themeState.getDarkTheme
                                    ? const Color(0xFF335171)
                                    : const Color(0xFF001B36),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      FittedBox(
                          child: ReusibleText(
                        text: 'Total amount: \$19484',
                        textfontWeight: FontWeight.w600,
                      ))
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: cartItemsList.length,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                            value: cartItemsList[index],
                            child: CartWidget(
                              q: cartItemsList[index].quantity,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
  }
}
