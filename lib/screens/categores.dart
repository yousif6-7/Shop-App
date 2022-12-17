import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/widgets.dart';

import '../models/producys_models.dart';
import '../provider/dark_theme_provider.dart';
import '../providers/models_provider.dart';

class Categories extends StatelessWidget {
  Categories({Key? key, }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: ReusibleText(
          text: 'Categories',
          size: 30,
          textfontWeight: FontWeight.bold,
        ),
        centerTitle: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Category').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          //print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data.docs.isEmpty) {
              return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ReusibleText(text: 'Your store is empty'),
                  ));
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: ((context, index) => CategoriesWidth(
                  gridimgpath:snapshot.data!.docs[index]['imageUrl'] ,
                  gridText: snapshot.data!.docs[index]['productCategoryName'],
                )),
              );
            } else {
              return ReusibleText(text: "Error");
            }
          }
          return ReusibleText(text: "Something went wrong");
        },
      ),
    );
  }
}
