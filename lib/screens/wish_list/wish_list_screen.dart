import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/wish_list_provider.dart';
import 'package:shop_app/screens/wish_list/wish_list_widget.dart';

import '../../consts/widgets.dart';
import '../../consts/widgets/cart_empty.dart';
import '../../providers/cart_provider.dart';
import '../../services/methods.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishListProvider>(context);
    final wishlistItemsList =
    wishlistProvider.getwishListItems.values
        .toList()
        .reversed
        .toList();
    return wishlistItemsList.isEmpty
        ? const EmptyScreen(
      imagepath: 'assets/images/clips/history.png',
      title: 'Whoops',
      subtitle: 'Your History is empty for now ',

    )
        : Scaffold(
      appBar: AppBar(
        title: ReusibleText(
          text: 'Wish List(${wishlistItemsList.length})',
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
                    subtitle: "Do you want to  clear your wish list ?",
                    function: () {
                      wishlistProvider.clearWishList();
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
      body: ListView.builder(
          itemCount: wishlistItemsList.length,
          itemBuilder: (context, index) {
            return ChangeNotifierProvider.value(
                value: wishlistItemsList[index],
                child: const WishListWidget());
          }),
    );
  }
}
