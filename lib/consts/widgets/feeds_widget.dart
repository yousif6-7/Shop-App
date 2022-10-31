import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/widgets/heart.dart';
import 'package:shop_app/consts/widgets/price_widget.dart';
import 'package:shop_app/models/cart_models.dart';
import 'package:shop_app/models/producys_models.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/models_provider.dart';

import '../../provider/dark_theme_provider.dart';
import '../../providers/wish_list_provider.dart';
import '../../screens/product_det_screen.dart';
import '../../services/methods.dart';
import '../firebase_const.dart';
import '../widgets.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final qantityController = TextEditingController();
  


  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    final ProductModelsvar = Provider.of<ProductModels>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart =
        cartProvider.getCartItems.containsKey(ProductModelsvar.id);
    final wishListProvider = Provider.of<WishListProvider>(context);
    bool? _isInWishlist =
        wishListProvider.getwishListItems.containsKey(ProductModelsvar.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusibleText(
          text: ProductModelsvar.title,
          size: 15,
          textfontWeight: FontWeight.w500,
        ),
        Container(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                width: 300,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      ProductModelsvar.imageUrl,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: PriceWidget(
                        saleprice: ProductModelsvar.salePrice,
                        price: double.parse(ProductModelsvar.price),
                        isonsale: true,
                        textprice: '1',
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: _isInCart
                              ? null
                              : () {
                                  cartProvider.addProductToCart(
                                      productid: ProductModelsvar.id,
                                      quantity: 1);
                                },
                          icon: Icon(_isInCart ? Icons.check : IconlyLight.bag,
                              color: themeState.getDarkTheme
                                  ? Colors.white
                                  : Color(0xFF00264D)),
                        ),
                        HeartWidget(
                          productId: ProductModelsvar.id,
                          isInwishList: _isInWishlist,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "ProductDetScreen",
                                arguments: ProductModelsvar.id);
                          },
                          icon: Icon(IconlyLight.arrowRightCircle,
                              color: themeState.getDarkTheme
                                  ? Colors.white
                                  : Color(0xFF00264D)),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
