import 'package:flutter/material.dart';
import 'package:shop_app/consts/widgets.dart';
class HomeEmptyScreen extends StatelessWidget {
  const HomeEmptyScreen(
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
    return Padding(
      padding: const EdgeInsets.all(30),
      child: SizedBox(
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
    );
  }
}
