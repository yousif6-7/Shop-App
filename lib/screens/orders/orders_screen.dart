import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../consts/widgets.dart';
import '../../consts/widgets/cart_empty.dart';
import '../../provider/dark_theme_provider.dart';

import '../../providers/orders_provider.dart';
import '../../services/methods.dart';
import 'orders_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    final orderProvider = Provider.of<OrdersProvider>(context);
    final ordersList =
    orderProvider.getOrderItems.values.toList().reversed.toList();
    return ordersList.isEmpty
        ? const EmptyScreen(
      imagepath: 'assetts/clips/orders.png',
      title: 'Whoops',
      subtitle: 'You dont have any ordrs till now ',

    )
        : Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: themeState.getDarkTheme
              ? const Color(0xFFececec)
              : const Color(0xFF00264D),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: ReusibleText(
          text: 'Orders(${ordersList.length})',
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
                    subtitle: "Do you want to  clear your orders list ?",
                    function: () {},
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
          itemCount: ordersList.length,
          itemBuilder: (context, index) {
            return ChangeNotifierProvider.value(
                value: ordersList[index], child: const OrdersWidget());
          }),
    );
  }
}
