import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/widgets.dart';
import 'package:shop_app/consts/widgets/heart.dart';

import '../consts/firebase_const.dart';
import '../models/producys_models.dart';
import '../provider/dark_theme_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/models_provider.dart';
import '../services/methods.dart';

class ProductDetScreen extends StatefulWidget {
  const ProductDetScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetScreen> createState() => _ProductDetScreenState();
}

class _ProductDetScreenState extends State<ProductDetScreen> {
  PageController pageController = PageController();
  var currentValue = 0.0;
  int counter = 1;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final productProviders = Provider.of<ProductProvider>(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final ProductModels getCurrentProduct =
    productProviders.findProductById(productId);

    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart =
    cartProvider.getCartItems.containsKey(getCurrentProduct.id);

    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : double.parse(getCurrentProduct.price);
    double totalPrice = usedPrice * int.parse(counter.toString());
    return Scaffold(
      backgroundColor:
      themeState.getDarkTheme ?  Color(0xFF335171) : Color(0xFFececec),
      body: Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            width: double.maxFinite,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(getCurrentProduct.imageUrl),
              ),
            ),
          ),
        ),
        Positioned(
          left: 10,
          right: 0,
          top: 50,
          child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                  ))),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 280,
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            decoration: BoxDecoration(
              color: themeState.getDarkTheme
                  ? Color(0xFF335171)
                  : Color(0xFF0ececec),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  20,
                ),
                topRight: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ReusibleText(
                    text: getCurrentProduct.title,
                    size: 20,
                    textfontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ReusibleText(
                      text:
                      'Great and warm wool jacket made in turkey with a lot of colors to chose from.'),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: ReusibleText(
                          text: 'Available sizes: ${getCurrentProduct.size}')),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ReusibleText(
                      text: 'Available colors: ${getCurrentProduct.color}',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ReusibleText(
                        text: '\$${usedPrice.toStringAsFixed(2)}',
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: getCurrentProduct.isOnSale ? true : false,
                        child: Text(
                          '\$${getCurrentProduct.price}',
                          style:
                          TextStyle(decoration: TextDecoration.lineThrough),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: ((context, index) {
                        return Container(
                          height: 100,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/home/homeimg1.jpeg',
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  DotsIndicator(
                    dotsCount: 5,
                    position: currentValue,
                    decorator: DotsDecorator(
                        activeColor: themeState.getDarkTheme
                            ? Color(0xFFececec)
                            : Color(0xFF00264D),
                        size: Size.square(9.0),
                        activeSize: Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          color:
          themeState.getDarkTheme ? Color(0xFF0ececec) : Color(0xFFCCD4DB),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 150,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _isInCart
                    ? themeState.getDarkTheme
                    ? Color(0xFF335171)
                    : Color(0xFFececec)
                    : null,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (counter <= 1) {
                        } else {
                          counter--;
                        }
                      });
                    },
                    icon: Icon(
                      Icons.remove,
                      color: themeState.getDarkTheme
                          ? Color(0xFFececec)
                          : Color(0xFF00264D),
                    ),
                  ),
                  ReusibleText(
                    text: '${counter.toString()}',
                    size: 25,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (counter >= 99) {
                        } else if (_isInCart) {
                          return;
                        } else {
                          counter++;
                        }
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      color: themeState.getDarkTheme
                          ? Color(0xFFececec)
                          : Color(0xFF00264D),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (counter == 0) {
                } else if (_isInCart) {
                  return;
                } else {
                  cartProvider.addProductToCart(
                      productid: getCurrentProduct.id, quantity: counter);
                }
              },
              child: Container(
                width: 130,
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: themeState.getDarkTheme
                        ? Color(0xFF335171)
                        : Color(0xFFececec)),
                child: Column(
                  children: [
                    ReusibleText(
                      text: '\$${totalPrice.toStringAsFixed(2)}',
                    ),
                    ReusibleText(text: _isInCart ? 'In cart' : 'Add to cart')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
