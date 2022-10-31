import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/models_provider.dart';
import '../screens/btm_nav_bar.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {

  @override
  void initState() {
  Future.delayed(Duration(microseconds: 5),() async{
    final productsProvider =  Provider.of<ProductProvider>(context,listen: false);
    await productsProvider.fetchData();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BtmNavBarScreen()));
  });
   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
