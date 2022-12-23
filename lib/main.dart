import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/dark_theme_provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/google_sign_in_provider.dart';
import 'package:shop_app/providers/models_provider.dart';
import 'package:shop_app/providers/orders_provider.dart';
import 'package:shop_app/providers/wish_list_provider.dart';
import 'package:shop_app/screens/log_in/log_in_screen.dart';
import 'package:shop_app/screens/product_det_screen.dart';
import 'package:shop_app/screens/sub_categories.dart';

import 'consts/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // PREFER CONST
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _firebaseinitization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseinitization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("An Error happend"),
              ),
            ),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => themeChangeProvider,
            ),
            ChangeNotifierProvider(
              create: (_) => ProductProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => CartProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => WishListProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => GoogleSignInProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => OrdersProvider(),
            ),
          ],
          child: Consumer<DarkThemeProvider>(
              builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: Style.themeData(themeProvider.getDarkTheme, context),
              home: LogInScreen(),
              routes: {
                'ProductDetScreen': (context) => const ProductDetScreen(),
                'SubCategories': (context) => const SubCategories(),
              },
            );
          }),
        );
      },
    );
  }
}
