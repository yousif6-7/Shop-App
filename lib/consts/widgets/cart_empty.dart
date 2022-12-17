import 'package:flutter/material.dart';
import 'package:shop_app/consts/widgets.dart';

import '../../screens/tab_bar_screen.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {Key? key,
        required this.imagepath,
        required this.title,
        required this.subtitle,
      })
      : super(key: key);
  final String imagepath;
  final String title;
  final String subtitle;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
          height: 500,
          child: Column(
            children: [
              Container(

                margin: EdgeInsets.only(top: 20),

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

            ],
          ),
        ),
      ),
    );
  }
}
