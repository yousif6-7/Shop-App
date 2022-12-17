import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/user.dart';
import '../provider/dark_theme_provider.dart';
import '../providers/cart_provider.dart';
import 'cart/cart_screen.dart';
import 'categores.dart';
import 'home_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: _pages.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final List _pages = [
    const HomeScreen(),
    Categories(),
    const Cart(),
    const Users(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(bottom: 15,top: 40),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  child: TabBarView(
                    controller: controller,
                    children:  [
                      HomeScreen(),
                      Categories(),

                      Cart(),
                      Users(),
                    ],
                  ),
                ),
              ),
              Container(
                child: TabBar(
                  labelColor: themeState.getDarkTheme
                      ? const Color(0xFFececec)
                      : const Color(0xFF00264D),
                  unselectedLabelColor: const Color(0xFF8c8c8c),
                  controller: controller,
                  indicatorColor: Colors.transparent,
                  isScrollable: false,
                  tabs: [
                    const Tab(
                      icon: Icon(
                        IconlyBold.home,size: 30,
                      ),
                    ),const Tab(
                      icon: Icon(
                        IconlyBold.category,size: 30,
                      ),
                    ),
                    Tab(
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
                          child: const Icon(
                              IconlyBold.buy,size: 30
                          )),
                    ),
                    const Tab(
                      icon: Icon(
                          IconlyBold.setting,size: 30
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
