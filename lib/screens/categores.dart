import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/widgets.dart';

import '../models/producys_models.dart';
import '../provider/dark_theme_provider.dart';
import '../providers/models_provider.dart';

class Categories extends StatelessWidget {
  Categories({Key? key, required this.gridText}) : super(key: key);
  List<Map<String, dynamic>> gridList = [
    {
      'gridimgpath': 'assets/images/shoes/shoe1.png',
      'gridText': 'shoes',
    },
    {
      'gridimgpath': 'assets/images/dresses/dreaes1.png',
      'gridText': 'Dresses',
    },
    {
      'gridimgpath': 'assets/images/pants/pants1.jpeg',
      'gridText': 'Pants',
    },
    {
      'gridimgpath': 'assets/images/shirts/shirts1.png',
      'gridText': 'Shirt',
    },
    {
      'gridimgpath': 'assets/images/suts/suts1.jpeg',
      'gridText': 'Suits',
    },
    {
      'gridimgpath': 'assets/images/tshirts/tshirts1.jpeg',
      'gridText': 'T-Shirts',
    },
  ];
  final String gridText;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final productProviders = Provider.of<ProductProvider>(context);

    List<ProductModels> allproducts = productProviders.getproductList;

    List<ProductModels> cats = [];
    //i used tmp cats b/c dart doesnt allow us to modify elements while iterating through them
    List<ProductModels> tmpCats = [];
    for (ProductModels product in allproducts) {
      //first check if categories are not empty if so , atleast we have to add 1 item to it
      if (cats.isNotEmpty) {
        //if it is not we have to make sure that if the selected product is not in our category list
        for (ProductModels cat in cats) {
          if (product.productcat != cat.productcat) tmpCats.add(product);
        }
      } else {
        cats.add(product);
      }
    }
    cats.addAll(tmpCats);
    print(cats[0].title);
    return Scaffold(
      appBar: AppBar(
        title: ReusibleText(
          text: 'Categories',
          size: 30,
          textfontWeight: FontWeight.bold,
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        //shrinkWrap: true,
        itemCount: cats.length,
        itemBuilder: ((context, index) => ChangeNotifierProvider.value(
              value: allproducts[index],
              child: CategoriesWidth(
                gridimgpath: cats[index].imageUrl,
                gridText: cats[index].productcat,
              ),
            )),
      ),
    );
  }
}
