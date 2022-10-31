import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_det_screen.dart';

import '../../models/producys_models.dart';
import '../../provider/dark_theme_provider.dart';
import '../../providers/models_provider.dart';
import '../widgets.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key, required this.productModel}) : super(key: key);


 final List<ProductModels>  productModel ;

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  List<String> offersImages = [
    'assets/images/shoes/shoe1.png',
    'assets/images/dresses/dreaes1.png',
    'assets/images/pants/pants1.jpeg',
    'assets/images/shirts/shirts1.png',
    'assets/images/suts/suts1.jpeg',
    'assets/images/tshirts/tshirts1.jpeg',
  ];
  PageController pageController = PageController(viewportFraction: 0.90);
  var _currentpagevalue = 0.0;
  double _ScaleFactor = 0.8;
  double _height = 350;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentpagevalue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final productProviders = Provider.of<ProductProvider>(context);
    List<ProductModels> OnSaleProducts = productProviders.getOnSaleProducts;

    return Column(children: [
      //Slider
      Container(
        height: 240,
        child: PageView.builder(
            controller: pageController,
            itemCount: OnSaleProducts.length < 6 ? OnSaleProducts.length : 6,
            itemBuilder: (context, index) {
              return _buildbodyitem(index, context);
            }),
      ),
      DotsIndicator(
        dotsCount: OnSaleProducts.length < 6 ? OnSaleProducts.length : 6,
        position: _currentpagevalue,
        decorator: DotsDecorator(
            activeColor:
                themeState.getDarkTheme ? Color(0xFFececec) : Color(0xFF00264D),
            size: Size.square(9.0),
            activeSize: Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0))),
      ),

      //Food List
    ]);
  }

  Widget _buildbodyitem(int index, context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    //final ProductModelsvar = Provider.of<ProductModels>(context);

    Matrix4 matrix = Matrix4.identity();
    if (index == _currentpagevalue.floor()) {
      var currScale = 1 - (_currentpagevalue - index) * (1 - _ScaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentpagevalue.floor() + 1) {
      var currScale =
          _ScaleFactor + (_currentpagevalue - index + 1) * (1 - _ScaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentpagevalue.floor() - 1) {
      var currScale = 1 - (_currentpagevalue - index) * (1 - _ScaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, _height * (1 - _ScaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, "ProductDetScreen",
                arguments: widget. productModel[index].id);
          },
          child: Container(
            height: 200,
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget. productModel[index].imageUrl),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 50,
            width: 200,
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: themeState.getDarkTheme ? Color(0xFF335171) : Colors.white,
            ),
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: ReusibleText(
                  text: widget. productModel[index].title,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
