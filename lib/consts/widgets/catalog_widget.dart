import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_det_screen.dart';

import '../../models/producys_models.dart';
import '../../provider/dark_theme_provider.dart';
import '../../providers/wish_list_provider.dart';
import '../widgets.dart';
import 'heart.dart';

class WinterCatalogWidget extends StatefulWidget {
  const WinterCatalogWidget({Key? key}) : super(key: key);

  @override
  State<WinterCatalogWidget> createState() => _WinterCatalogWidgetState();
}

class _WinterCatalogWidgetState extends State<WinterCatalogWidget> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final ProductModelsvar = Provider.of<ProductModels>(context);
    final wishListProvider = Provider.of<WishListProvider>(context);
    bool? _isInWishlist =
    wishListProvider.getwishListItems.containsKey(ProductModelsvar.id);
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
                text: 'winter outfit',
                size: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusibleText(
                        text: 'Price: \$100',
                        size: 15,
                      ),
                      ReusibleText(
                        text: 'The 2022 collections',
                        size: 12,
                      ),
                      Row(
                        children: [
                          HeartWidget(
                            productId: ProductModelsvar.id,
                            isInwishList: _isInWishlist,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(IconlyLight.bag,
                                color: themeState.getDarkTheme
                                    ? Colors.white
                                    : Color(0xFF00264D)),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "ProductDetScreen",arguments: ProductModelsvar.id);

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
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/home/homeimg1.jpeg',
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
