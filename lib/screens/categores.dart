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
        itemCount: gridList.length,
        itemBuilder: ((context, index) => 
           ChangeNotifierProvider.value(
              value:allproducts[index],
              child: CategoriesWidth(
                gridimgpath: allproducts[index].imageUrl,
                gridText:"",
              ),
            )),
      ),
    );
  }
}
