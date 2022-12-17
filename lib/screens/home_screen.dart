import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_app/consts/widgets/cart_empty.dart';
import 'package:shop_app/consts/widgets/feeds_widget.dart';
import 'package:shop_app/consts/widgets/slider.dart';
import 'package:shop_app/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/on_sale_screen.dart';
import 'package:shop_app/screens/product_det_screen.dart';
import 'package:shop_app/screens/winter_catalog.dart';

import '../consts/widgets.dart';
import '../consts/widgets/home_ephty_sec.dart';
import '../consts/widgets/indecator.dart';
import '../models/producys_models.dart';
import '../providers/models_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModels> searchList = [];
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
    List<ProductModels> OnSaleProducts = productProviders.getOnSaleProducts;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: const EdgeInsets.only(bottom: 40, right: 10),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () {
                showSearch(context: context, delegate: SearchClass());
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(
              //   height: 40,
              // ),
              // SizedBox(
              //   height: kBottomNavigationBarHeight,
              //   child: TextField(
              //     onChanged: (value) {
              //       setState(() {
              //         searchList = productProviders.searching(value);
              //       });
              //     },
              //     focusNode: _searchFocusNode,
              //     controller: _searchControlar,
              //     decoration: InputDecoration(
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(20),
              //         borderSide:
              //             const BorderSide(color: Color(0xFF00264D), width: 1),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(20),
              //         borderSide:
              //             const BorderSide(color: Color(0xFF00264D), width: 1),
              //       ),
              //       prefixIcon: const Icon(Icons.search),
              //       suffix: IconButton(
              //         onPressed: () {
              //           _searchControlar.clear();
              //           _searchFocusNode.unfocus();
              //         },
              //         icon: Icon(Icons.cancel,
              //             color: _searchFocusNode.hasFocus
              //                 ? Colors.red
              //                 : const Color(0xFF00264D)),
              //       ),
              //       hintText: 'Whats on your mind ?',
              //     ),
              //   ),
              // ),

              _searchControlar.text.isNotEmpty && searchList.isEmpty
                  ? const HomeEmptyScreen(
                  imagepath: 'assets/images/box.png',
                  title: 'title',
                  subtitle: 'subtitle')
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  SliderWidget(productModel: OnSaleProducts),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ReusibleText(
                      text: 'Oer winter catalog is here ',
                      size: 20,
                      textfontWeight: FontWeight.bold,
                    ),
                  ),
                  //
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: double.maxFinite,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      image: const DecorationImage(
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
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10),
                              child: ReusibleText(
                                text: 'CHECK IT NOW!',
                                textfontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {

                                   
                                  },
                                  icon: Icon(
                                    IconlyLight.arrowRightCircle,
                                    color: themeState.getDarkTheme
                                        ? Colors.white
                                        : const Color(0xFF00264D),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  Container(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _searchControlar.text.isNotEmpty
                          ? searchList.length
                          : OnSaleProducts.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: _searchControlar.text.isNotEmpty
                              ? searchList[index]
                              : OnSaleProducts[index],
                          child: const FeedsWidget(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class SearchClass extends SearchDelegate<String> {
  List<ProductModels> recentSearch = [];

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        query = '';
      },
    ),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back_ios),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  @override
  Widget buildResults(BuildContext context) {
    final productProviders = Provider.of<ProductProvider>(context);
    List<ProductModels> allproducts = productProviders.getproductList;

    final results = query.isEmpty
        ? recentSearch
        : allproducts.where((element) {
      final elToL = element.title.toLowerCase();
      final qToL = query.toLowerCase();
      return elToL.startsWith(qToL);
    }).toList();
    return buildResultSuccess(results);
  }
  Widget buildResultSuccess(List<ProductModels> results) =>
      Container(
        height: 500,
        child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              final idd = result.id;
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListTile(
                  onTap: () {
                    recentSearch.add(result);
                    Navigator.pushNamed(context, "ProductDetScreen",
                        arguments: idd);
                  },
                  leading: Container(
                    height: 100,
                    width: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: result.imageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          child: const Indecator(isLoading: true),
                        ),
                      ),
                    ),
                  ),
                  title: ReusibleText(
                    text: result.title,
                  ),
                ),
              );
            }),
      );
  @override
  Widget buildSuggestions(BuildContext context) {
    final productProviders = Provider.of<ProductProvider>(context);
    List<ProductModels> allproducts = productProviders.getproductList;
    final suggestions = query.isEmpty
        ? recentSearch
        : allproducts.where((element) {
      final elToL = element.title.toLowerCase();
      final qToL = query.toLowerCase();
      return elToL.startsWith(qToL);
    }).toList();
    return buildSuggestionsSuccess(suggestions);

  }
  Widget buildSuggestionsSuccess(List<ProductModels> suggestions) => Container(
    height: 500,
    child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggest = suggestions[index];
          final idd = suggest.id;
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListTile(
              onTap: () {

                Navigator.pushNamed(context, "ProductDetScreen",
                    arguments: idd);
              },
              leading: Container(
                height: 100,
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: suggest.imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      alignment: Alignment.center,
                      child: const Indecator(isLoading: true),
                    ),
                  ),
                ),
              ),
              title: ReusibleText(
                text: suggest.title,
              ),
            ),
          );
        }),
  );

}
