import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/widgets.dart';
import '../../models/producys_models.dart';
import '../../provider/dark_theme_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/models_provider.dart';
import '../../screens/product_det_screen.dart';

class SubCatWidget extends StatefulWidget {
  const SubCatWidget({Key? key}) : super(key: key);

  @override
  State<SubCatWidget> createState() => _SubCatWidgetState();
}

class _SubCatWidgetState extends State<SubCatWidget> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final ProductModelsvar = Provider.of<ProductModels>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    bool _isInCart = cartProvider.getCartItems.containsKey(ProductModelsvar.id);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.only(right: 10),
        height: 180,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: themeState.getDarkTheme ? Color(0xFF335171) : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusibleText(
                text: ProductModelsvar.title,
                size: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusibleText(
                        text: 'Price: \$${ProductModelsvar.price}',
                        size: 15,
                      ),
                      ReusibleText(
                        text: 'The new Nick Air force 2022',
                        size: 12,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (_isInCart) {
                                return;
                              } else {
                                cartProvider.addProductToCart(
                                    productid: ProductModelsvar.id, quantity: 1);
                              }
                            },
                            icon: Icon(IconlyLight.bag,
                                color: themeState.getDarkTheme
                                    ? Colors.white
                                    : Color(0xFF00264D)),
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
                  Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          ProductModelsvar.imageUrl,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
