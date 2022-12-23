import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/wish_list_provider.dart';

import '../../provider/dark_theme_provider.dart';

class HeartWidget extends StatelessWidget {
  const HeartWidget(
      {Key? key, required this.productId, this.isInwishList = false})
      : super(key: key);
  final String productId;
  final bool? isInwishList;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final wishListProvider = Provider.of<WishListProvider>(context);

    return IconButton(
      onPressed: () {
        wishListProvider.addAndRemoveProdToWishList(productId: productId);
      },
      icon: Icon(
        isInwishList != null && isInwishList == true
            ? IconlyBold.heart
            : IconlyLight.heart,
        color: isInwishList != null && isInwishList == true
            ? Colors.red
            : Colors.black,
      ),
    );
  }
}
