import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/firebase_const.dart';
import 'package:shop_app/consts/widgets/price_widget.dart';
import 'package:shop_app/services/methods.dart';

import '../../models/producys_models.dart';
import '../../provider/dark_theme_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/models_provider.dart';
import '../../screens/product_det_screen.dart';
import '../widgets.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    final ProductModelsvar = Provider.of<ProductModels>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool _isInCart = cartProvider.getCartItems.containsKey(ProductModelsvar.id);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReusibleText(
            text: ProductModelsvar.title,
            size: 15,
            textfontWeight: FontWeight.w500,
          ),
          Container(
            height: 200,
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
                      image: AssetImage(
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
                          isonsale: ProductModelsvar.isOnSale,
                          textprice: '1',
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: _isInCart
                                ? null
                                : () {
                                    cartProvider.addProductToCart(
                                        productid: ProductModelsvar.id,
                                        quantity: 1);
                                  },
                            icon: Icon(
                                _isInCart ? Icons.check : IconlyLight.bag,
                                color: themeState.getDarkTheme
                                    ? Colors.white
                                    : Color(0xFF00264D)),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetScreen()),
                              );
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
      ),
    );
  }
}
