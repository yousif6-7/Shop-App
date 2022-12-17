import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
import 'indecator.dart';

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
    final productProviders = Provider.of<ProductProvider>(context);

    final wishListProvider = Provider.of<WishListProvider>(context);
    List<ProductModels> productsByCat =
    productProviders.findByCategory(ProductModelsvar.productcat);



    List<ProductModels> allproducts = productProviders.getproductList;
    List<ProductModels> OnSaleProducts = productProviders.getOnSaleProducts;



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ReusibleText(
          text: 'Our top sales',
          size: 20,
          textfontWeight: FontWeight.w600,
        ),
        const SizedBox(
          height: 10,
        ),
        ReusibleText(
          text: ProductModelsvar.productcat,
          size: 15,
          textfontWeight: FontWeight.w500,
        ),
        Container(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productsByCat.length,
            itemBuilder: (context, index) {
              bool? _isInCart = cartProvider.getCartItems
                  .containsKey(productsByCat[index].id);
              bool? _isInWishlist =
              wishListProvider.getwishListItems.containsKey(productsByCat[index].id);
              return Container(
                height: 100,
                width: 300,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // image: DecorationImage(
                  //   fit: BoxFit.cover,
                  //   image: NetworkImage(productsByCat[index].imageUrl),
                  // ),
                ),
                child: Stack(children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: productsByCat[index].imageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          child:  Indecator(isLoading: true),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    decoration:BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
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
                                    productid: productsByCat[index].id,
                                    quantity: 1);
                              },
                              icon: Icon(
                                  _isInCart ? Icons.check : IconlyLight.bag,
                                  color: themeState.getDarkTheme
                                      ? Colors.white
                                      : const Color(0xFF00264D)),
                            ),
                            HeartWidget(
                              productId: productsByCat[index].id,
                              isInwishList: _isInWishlist,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "ProductDetScreen",
                                    arguments: productsByCat[index].id);
                              },
                              icon: Icon(IconlyLight.arrowRightCircle,
                                  color: themeState.getDarkTheme
                                      ? Colors.white
                                      : const Color(0xFF00264D)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ]),
              );
            },
          ),
        ),
      ],
    );
  }
}
