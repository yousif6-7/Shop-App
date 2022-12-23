import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/widgets/catalog_widget.dart';
import '../models/producys_models.dart';
import '../providers/models_provider.dart';

class WinterCatalog extends StatefulWidget {
  const WinterCatalog({Key? key}) : super(key: key);

  @override
  State<WinterCatalog> createState() => _WinterCatalogState();
}

class _WinterCatalogState extends State<WinterCatalog> {
  @override
  Widget build(BuildContext context) {
    final productProviders = Provider.of<ProductProvider>(context);
    List<ProductModels> allproducts = productProviders.getProductList;

    List<ProductModels> OnSaleProducts = productProviders.getOnSaleProducts;
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: double.maxFinite,
        child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: OnSaleProducts[index],
                child: WinterCatalogWidget(),
              );
            }),
      ),
    );
  }
}
