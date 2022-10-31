import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_app/consts/widgets/feeds_widget.dart';
import 'package:shop_app/consts/widgets/slider.dart';
import 'package:shop_app/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/on_sale_screen.dart';
import 'package:shop_app/screens/winter_catalog.dart';

import '../consts/widgets.dart';
import '../consts/widgets/heart.dart';
import '../models/producys_models.dart';
import '../providers/models_provider.dart';
import '../providers/wish_list_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchControlar = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  IconData? icon;


  @override
  void dispose() {
    _searchControlar.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final productProviders = Provider.of<ProductProvider>(context);
    List<ProductModels> allproducts = productProviders.getproductList;
    List<ProductModels> OnSaleProducts = productProviders.getOnSaleProducts;

    return Scaffold(
      appBar: AppBar(
        leading: Stack(children: [
          CircleAvatar(),
        ]),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: kBottomNavigationBarHeight,
                child: TextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  focusNode: _searchFocusNode,
                  controller: _searchControlar,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(color: Color(0xFF00264D), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(color: Color(0xFF00264D), width: 1),
                    ),
                    prefixIcon: Icon(Icons.search),
                    suffix: IconButton(
                      onPressed: () {
                        _searchControlar.clear();
                        _searchFocusNode.unfocus();
                      },
                      icon: Icon(Icons.cancel,
                          color: _searchFocusNode.hasFocus
                              ? Colors.red
                              : Color(0xFF00264D)),
                    ),
                    hintText: 'Whats on your mind ?',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OnSaleScreen()),
                  );
                },
                child: ReusibleText(
                  text: 'View All',
                  size: 20,
                ),
              ),
              SliderWidget(productModel: OnSaleProducts

              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ReusibleText(
                  text: 'Oer winter catalog is here ',
                  size: 20,
                  textfontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: double.maxFinite,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/home/homeimg1.jpeg',
                    ),
                  ),
                ),
                child: Stack(
                  //alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: ReusibleText(
                            text: 'CHECK IT NOW!',
                            textfontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WinterCatalog()),
                                );
                              },
                              icon: Icon(
                                IconlyLight.arrowRightCircle,
                                color: themeState.getDarkTheme
                                    ? Colors.white
                                    : Color(0xFF00264D),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ReusibleText(
                text: 'Our top sales',
                size: 20,
                textfontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: allproducts.length,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      child: FeedsWidget(),
                      value: allproducts[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
