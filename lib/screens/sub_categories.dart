import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/widgets/sub_categories_widget.dart';
import '../models/producys_models.dart';
import '../providers/models_provider.dart';

class SubCategories extends StatefulWidget {
  const SubCategories({Key? key}) : super(key: key);

  @override
  State<SubCategories> createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  @override
  Widget build(BuildContext context) {
    final productProviders = Provider.of<ProductProvider>(context);
    final catName = ModalRoute.of(context)!.settings.arguments as String;

    List<ProductModels> productsByCat =
        productProviders.findByCategory(catName);
    return Scaffold(
      appBar: AppBar(),
      body: productsByCat.isEmpty
          ? Center(child: Text('Nothing'))
          : Container(
              height: double.maxFinite,
              child: ListView.builder(
                  itemCount: productsByCat.length,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: productsByCat[index],
                      child: SubCatWidget(),
                    );
                  }),
            ),
    );
  }
}
