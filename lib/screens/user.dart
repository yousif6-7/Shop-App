import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/firebase_const.dart';
import 'package:shop_app/consts/widgets.dart';
import 'package:shop_app/consts/widgets/loading_manegar.dart';
import 'package:shop_app/screens/log_in/log_in_screen.dart';
import 'package:shop_app/screens/orders/orders_screen.dart';
import 'package:shop_app/screens/wish_list/wish_list_screen.dart';
import 'package:shop_app/services/methods.dart';

import '../provider/dark_theme_provider.dart';
import '../providers/google_sign_in_provider.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UserState();
}

class _UserState extends State<Users> {
  bool isLoading = false;
  final User? user = authInstance.currentUser;
  String? _name;
  String? _email;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    try {
      String _uid = user!.uid;
      final DocumentSnapshot userDocs =
      await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if (userDocs.data() == null) {
        _name = 'user';
        _email = 'un';
      } else {
        _name = userDocs.get('name');
        _email = userDocs.get('email');
      }
    } catch (error) {
      Methods.ErrorDailog(subtitle: '$error', context: context);
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color =
    themeState.getDarkTheme ? Color(0xFFececec) : Color(0xFF00264D);
    final googleProvider =
    Provider.of<GoogleSignInProvider>(context, listen: false);
    return LoadingManegar(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: RichText(
                    text: TextSpan(
                        text: 'Hi, ',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: user?.displayName ?? 'user',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ReusibleText(
                    text: user!.email!,
                    size: 15,
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                ListTileWidget(
                  title: 'Orders',
                  fontWeight: FontWeight.w700,
                  size: 20,
                  icon: IconlyLight.bag,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OrdersScreen()),
                    );
                  },
                ),
                ListTileWidget(
                  title: 'Wish list',
                  fontWeight: FontWeight.w700,
                  size: 20,
                  icon: IconlyLight.heart,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WishListScreen()),
                    );
                  },
                ),
                ListTileWidget(
                  title: 'Viewed',
                  fontWeight: FontWeight.w700,
                  size: 20,
                  icon: IconlyLight.show,
                  onPressed: () {},
                ),
                ListTileWidget(
                  title: 'Forget password',
                  fontWeight: FontWeight.w700,
                  size: 20,
                  icon: IconlyLight.unlock,
                  onPressed: () {},
                ),
                SwitchListTile(
                  value: themeState.getDarkTheme,
                  onChanged: (bool value) {
                    setState(() {
                      themeState.setDarkTheme = value;
                    });
                  },
                  secondary: Icon(themeState.getDarkTheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined),
                  title: ReusibleText(
                    text: themeState.getDarkTheme ? 'Dark theme' : 'Light theme',
                    size: 20,
                    textfontWeight: FontWeight.bold,
                  ),
                ),
                ListTileWidget(
                  title: 'Log out',
                  fontWeight: FontWeight.w700,
                  size: 20,
                  icon: IconlyLight.logout,
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    googleProvider.logout();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LogInScreen()));
                    // Methods.warningDialog(
                    //   title: "Sign Out ?",
                    //   subtitle: "Do you want to sign out ?",
                    //   function: () async {
                    //     googleProvider.logout();
                    //     Navigator.pushReplacement(context,
                    //         MaterialPageRoute(builder: (context) => LogInScreen()));
                    //   },
                    //   context: context,
                    // );
                  },
                ),
              ],
            )),
      ),
    );
  }
}
