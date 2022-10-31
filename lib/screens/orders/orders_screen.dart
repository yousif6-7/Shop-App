import 'package:flutter/material.dart';
import 'package:shop_app/consts/widgets/cart_empty.dart';
import 'package:shop_app/screens/orders/orders_widget.dart';

import '../../consts/widgets.dart';
import '../../services/methods.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isEmpty = true;
    return _isEmpty == true
        ? EmptyScreen(
            imagepath: 'assets/images/clips/orders.png',
            title: 'Whoops',
            subtitle: 'You dont have any ordrs till now ',
            text: 'Start shopping now',
          )
        : Scaffold(
            appBar: AppBar(
              title: ReusibleText(
                text: 'Orders(2)',
                size: 20,
                textfontWeight: FontWeight.bold,
              ),
              centerTitle: false,
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 50,
                  decoration: BoxDecoration(
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
                      icon: Icon(Icons.delete),
                    ),
                  ),
                ),
              ],
            ),
            body: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return OrdersWidget();
                }),
          );
  }
}
