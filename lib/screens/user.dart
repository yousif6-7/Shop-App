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

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UserState();
}

class _UserState extends State<Users> {
  final TextEditingController addresscontroller =
      TextEditingController(text: '');
  bool isLoading = false;
  final User? user = authInstance.currentUser;
  String? _name;
  String? _email;
  String? _address;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      isLoading = true;
    });
    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    try {
      String _uid = user!.uid;
      final DocumentSnapshot userDocs =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if (userDocs == null) {
        return;
      } else {
        _email = userDocs.get('email');
        _name = userDocs.get('name');
        _address = userDocs.get('Address');
        addresscontroller.text = userDocs.get('Address');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      Methods.ErrorDailog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    addresscontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color =
        themeState.getDarkTheme ? Color(0xFFececec) : Color(0xFF00264D);
    return Scaffold(
      appBar: AppBar(),
      body: LoadingManegar(
        isLoading: isLoading,
        child: SingleChildScrollView(
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
                        text: _name == null ? "user" : _name,
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
                text: _email == null ? "Email" : _email!,
                size: 15,
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            ListTileWidget(
              title: 'Address',
              subtitle: _address,
              fontWeight: FontWeight.w700,
              size: 20,
              icon: IconlyLight.profile,
              onPressed: () {
                alartDialog( context: context);
              },
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
                Methods.warningDialog(
                  title: "Sign Out ?",
                  subtitle: "Do you want to sign out ?",
                  function: () async {
                    await authInstance.signOut();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LogInScreen(),
                      ),
                    );
                  },
                  context: context,
                );
              },
            ),
          ],
        )),
      ),
    );
  }

  Future<void> alartDialog({
    required BuildContext context,
  }) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: ReusibleText(
              text: "Update your address",
            ),
            actions: [
              TextField(
                controller: addresscontroller,
                maxLines: 2,
                decoration: InputDecoration(hintText: 'Your address'),
              ),
              TextButton(
                  onPressed: () async {
                    String _uid = user!.uid;
                    try {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(_uid)
                          .update({
                        'Address': addresscontroller.text,
                      });
                      Navigator.pop(context);
                    } catch (error) {
                      Methods.ErrorDailog(
                          subtitle: error.toString(), context: context);
                    }
                    setState(() {
                      _address = addresscontroller.text;
                    });
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          );
        });
  }
}
