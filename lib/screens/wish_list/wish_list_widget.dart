import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/widgets/heart.dart';
import 'package:shop_app/models/wish_list.dart';

import '../../consts/firebase_const.dart';
import '../../consts/widgets.dart';
import '../../provider/dark_theme_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/models_provider.dart';
import '../../providers/wish_list_provider.dart';
import '../../services/methods.dart';
import '../product_det_screen.dart';

class WishListWidget extends StatefulWidget {
  const WishListWidget({Key? key}) : super(key: key);

  @override
  State<WishListWidget> createState() => _WishListWidgetState();
}

class _WishListWidgetState extends State<WishListWidget> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    final productProviders = Provider.of<ProductProvider>(context);

    final wishlistModels = Provider.of<WishListModels>(context);
    final wishlistProvider = Provider.of<WishListProvider>(context);
    final getCurrentProduct =
    productProviders.findProductById(wishlistModels.productid);
    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : double.parse(getCurrentProduct.price);
    bool? _isInWishlist =
    wishlistProvider.getwishListItems.containsKey(getCurrentProduct.id);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(getCurrentProduct.id);


    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.maxFinite,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "ProductDetScreen",arguments: getCurrentProduct.id);

            },
            child: Container(
              width: 180,
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
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusibleText(
                text: getCurrentProduct.title,
                size: 20,
                textfontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: _isInCart
                        ? null
                        : () {
                      final User? user = authInstance.currentUser;
                      if (user == null) {
                        Methods.ErrorDailog(
                            subtitle:
                            "Error,You are not regestered",
                            context: context);
                        return;
                      }
                        cartProvider.addProductToCart(
                            productid: getCurrentProduct.id, quantity: 1);

                    },
                    icon: Icon(_isInCart ? Icons.check : IconlyLight.bag,
                        color: themeState.getDarkTheme
                            ? Colors.white
                            : Color(0xFF00264D)),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "ProductDetScreen",arguments: getCurrentProduct.id);

                    },
                    icon: Icon(IconlyLight.arrowRightCircle),
                  ),
                  HeartWidget(
                      productId: getCurrentProduct.id,
                    isInwishList: _isInWishlist,
                  ),
                ],
              ),
              ReusibleText(
                text: '\$${usedPrice.toStringAsFixed(2)}', size: 20, textfontWeight: FontWeight.w600,),
            ],
          ),
        ]),
      ),
    );
  }
}
