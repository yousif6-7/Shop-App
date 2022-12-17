import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/widgets.dart';
import 'package:shop_app/screens/categores.dart';
import 'package:shop_app/screens/home_screen.dart';
import 'package:shop_app/screens/user.dart';

import '../providers/cart_provider.dart';
import 'cart/cart_screen.dart';

class BtmNavBarScreen extends StatefulWidget {
  const BtmNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BtmNavBarScreen> createState() => _BtmNavBarScreenState();
}

class _BtmNavBarScreenState extends State<BtmNavBarScreen> {
  int _selectedindex = 0;
  final List _pages = [
    const HomeScreen(),
    Categories(
      gridText: '',
    ),
    const Cart(),
    const Users(),
  ];

  void _selectedscreen(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: _pages[_selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedscreen,
        currentIndex: _selectedindex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                  _selectedindex == 0 ? IconlyBold.home : IconlyLight.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(_selectedindex == 1
                  ? IconlyBold.category
                  : IconlyLight.category),
              label: 'Categories'),
          BottomNavigationBarItem(
            icon: Badge(
                toAnimate: true,
                shape: BadgeShape.circle,
                badgeColor: Colors.blue,
                borderRadius: BorderRadius.circular(8),
                badgeContent: FittedBox(
                  child: Text(
                     cartProvider.getCartItems.length.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                child: Icon(
                    _selectedindex == 2 ? IconlyBold.buy : IconlyLight.buy)),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedindex == 3 ? IconlyBold.user2 : IconlyLight.user2),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
