import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/widgets.dart';
import 'package:shop_app/consts/widgets/cart_empty.dart';
import 'package:shop_app/services/methods.dart';
import 'package:uuid/uuid.dart';

import '../../consts/firebase_const.dart';
import '../../consts/widgets/indecator.dart';
import '../../models/producys_models.dart';
import '../../provider/dark_theme_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/models_provider.dart';
import '../../providers/orders_provider.dart';
import 'cart_widget.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController addresscontroller = TextEditingController();
  TextEditingController phoneNumbercontroller = TextEditingController();

  @override
  void initState() {
    addresscontroller.text;
    phoneNumbercontroller.text;
    super.initState();
  }

  @override
  void dispose() {
    addresscontroller.dispose();
    phoneNumbercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList =
        cartProvider.getCartItems.values.toList().reversed.toList();
    final productProviders = Provider.of<ProductProvider>(context);

    double totalDiscount = 0.0;
    //her im making the total discount

    double total = 0.0;
    cartProvider.getCartItems.forEach((key, value) {
      final ProductModels getCurrentProduct =
          productProviders.findProductById(value.productid);

      total += double.parse(getCurrentProduct.price) * value.quantity;
      //this is the normal total
      // here im multiple the number of sets by the amount of the discount
      // which is the price of the free product=25
      double discount =
          value.quantity ~/ 3 * double.parse(getCurrentProduct.price);

      totalDiscount = total - discount;
    });

    return cartItemsList.isEmpty
        ? const EmptyScreen(
            imagepath: 'assets/images/clips/cart.png',
            title: 'Whoops',
            subtitle: 'Your cart is empty for now ',
          )
        : Scaffold(
            appBar: AppBar(
              title: ReusableText(
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
                            Methods.warningDialog(
                              title: "Clear ?",
                              subtitle: "Do you want to  clear your cart ?",
                              function: () async {
                                await cartProvider.clearDbCart();
                                cartProvider.clearCart();
                                Navigator.pop(context);
                              },
                              context: context,
                            );
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
                          onPressed: () async {
                            await alartDialog(
                                context: context,
                                totalPrice: total,
                                isLoading: isLoading,
                                address: addresscontroller.text);
                          },
                          child: Text(
                            'Submet order',
                            style: TextStyle(
                                color: themeState.getDarkTheme
                                    ? const Color(0xFF335171)
                                    : const Color(0xFF001B36),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      FittedBox(
                          child: ReusableText(
                        text:
                            'Total amount: \$${totalDiscount.toStringAsFixed(2)}',
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

  Future<void> alartDialog({
    required context,
    required double totalPrice,
    required bool isLoading,
    required String address,
  }) async {
    final themeState = Provider.of<DarkThemeProvider>(context, listen: false);

    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: ReusableText(
              text: "Pleas,provide your address and phone number",
              size: 20,
            ),
            actions: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: addresscontroller,
                      maxLines: 2,
                      decoration:
                          const InputDecoration(hintText: 'Your address'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "pleas enter a valid address";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneNumbercontroller,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        hintText: 'Phone number',
                      ),
                      validator: (value) {
                        if (value!.isEmpty && value.length < 11) {
                          return "pleas enter a valid phone number";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: ReusableText(
                      text: 'Cansel',
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          address = addresscontroller.text;
                          isLoading = true;
                        });
                        final isValid = _formKey.currentState!.validate();
                        if (isValid) {
                          User? user = authInstance.currentUser;
                          final orderId = const Uuid().v4();
                          final productProviders = Provider.of<ProductProvider>(
                              context,
                              listen: false);
                          final cartProvider =
                              Provider.of<CartProvider>(context, listen: false);
                          final orderProvider = Provider.of<OrdersProvider>(
                              context,
                              listen: false);
                          cartProvider.getCartItems.forEach((key, value) async {
                            final getCurrentProduct = productProviders
                                .findProductById(value.productid);

                            try {
                              await orderProvider.addToorder(
                                orderId: orderId,
                                time: Timestamp.now(),
                                userId: user!.uid,
                                productid: value.productid,
                                price:
                                    ((getCurrentProduct.price) * value.quantity)
                                        .toString(),
                                imageUrl: getCurrentProduct.imageUrl,
                                totalPrice: totalPrice.toStringAsFixed(2),
                                userName: user.displayName ?? 'user',
                                quantity: value.quantity,
                                address: address,
                                context: context,
                                productName: getCurrentProduct.title,
                                phoneNumber: phoneNumbercontroller.text,
                              );
                              // FirebaseFirestore.instance
                              //     .collection('orders')
                              //     .doc(orderId)
                              //     .set({
                              //   'orderId': orderId,
                              //   'userId': user!.uid,
                              //   'productId': value.productid,
                              //   'price':
                              //       (getCurrentProduct.price) * value.quantity,
                              //   'totalPrice': totalPrice,
                              //   'quantity': value.quantity,
                              //   'imageUrl': getCurrentProduct.imageUrl,
                              //   'userName': user.displayName,
                              //   'orderDate': Timestamp.now(),
                              //   'address': address,
                              // });
                              await cartProvider.clearDbCart();
                              cartProvider.clearCart();
                              await orderProvider.fetchOrders();
                            } catch (e) {
                              if (!mounted) return;
                              Methods.ErrorDailog(
                                  subtitle: '$e', context: context);
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          });
                          await Fluttertoast.showToast(
                              msg: 'Order submeted',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER);
                          Navigator.pop(context);
                        } else {
                          return;
                        }
                      },
                      child: isLoading
                          ? SizedBox(
                              height: 30,
                              width: 30,
                              child: Indecator(isLoading: isLoading))
                          : Text(
                              'Submet ',
                              style: TextStyle(
                                  color: themeState.getDarkTheme
                                      ? const Color(0xFFececec)
                                      : const Color(0xFF00264D)),
                            )),
                ],
              ),
            ],
          );
        });
  }
}
