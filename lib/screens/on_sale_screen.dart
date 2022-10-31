import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/widgets.dart';
import 'package:shop_app/consts/widgets/on_sale_widget.dart';

import '../models/producys_models.dart';
import '../providers/models_provider.dart';

class OnSaleScreen extends StatefulWidget {
  const OnSaleScreen({Key? key}) : super(key: key);

  @override
  State<OnSaleScreen> createState() => _OnSaleScreenState();
}

class _OnSaleScreenState extends State<OnSaleScreen> {
  @override
  Widget build(BuildContext context) {
    final productProviders = Provider.of<ProductProvider>(context);
    List<ProductModels> OnSaleProducts = productProviders.getOnSaleProducts;
    return Scaffold(
      appBar: AppBar(),
      body:OnSaleProducts.isEmpty?
          Center(
            child: Column(
              children: [
                ReusibleText(text: 'No seals yet'),
              ],
            ),
          )
      :SingleChildScrollView(

        child: Column(
          children: [
            ReusibleText(text: 'On sale '),
            Container(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: OnSaleProducts.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    child: OnSaleWidget(),
                    value: OnSaleProducts[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
