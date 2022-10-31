import 'package:flutter/material.dart';
import 'package:shop_app/consts/widgets.dart';
import 'package:shop_app/screens/home_screen.dart';

import '../../screens/btm_nav_bar.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {Key? key,
      required this.imagepath,
      required this.title,
      required this.subtitle,
      required this.text})
      : super(key: key);
  final String imagepath;
  final String title;
  final String subtitle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                width: double.maxFinite,
                child: Image.asset(
                  imagepath,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ReusibleText(
                text: '${title}!',
                size: 30,
                textfontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 10,
              ),
              ReusibleText(
                text: subtitle,
                size: 16,
                textfontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 10,
              ),
              ReusibleText(
                text: text,
                size: 16,
                textfontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
