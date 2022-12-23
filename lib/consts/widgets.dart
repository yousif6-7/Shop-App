import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class ListTileWidget extends StatelessWidget {
  ListTileWidget(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.fontWeight,
      this.size,
      this.color,
      this.subtitle,
      this.icon})
      : super(key: key);
  final String title;
  double? size;
  FontWeight? fontWeight;
  Color? color;
  String? subtitle;
  IconData? icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: size,
          fontWeight: fontWeight,
          color: themeState.getDarkTheme
              ? const Color(0xFFececec)
              : const Color(0xFF00264D),
        ),
      ),
      subtitle: Text(
        subtitle == null ? '' : subtitle!,
      ),
      leading: Icon(icon),
      trailing: const Icon(
        IconlyLight.arrowRight2,
      ),
      onTap: () {
        onPressed();
      },
    );
  }
}

class ReusableText extends StatelessWidget {
  final String text;
  double? size;
  FontWeight? textfontWeight;
  int maxLines = 2;

  ReusableText({
    Key? key,
    required this.text,
    this.size,
    this.textfontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Text(
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      text,
      style: TextStyle(
        fontWeight: textfontWeight,
        fontSize: size,
        color: themeState.getDarkTheme
            ? const Color(0xFFececec)
            : const Color(0xFF00264D),
      ),
    );
  }
}

class CategoriesWidth extends StatefulWidget {
  const CategoriesWidth({
    Key? key,
    required this.gridimgpath,
    required this.gridText,
  }) : super(key: key);
  final String gridimgpath;
  final String gridText;

  @override
  State<CategoriesWidth> createState() => _CategoriesWidthState();
}

class _CategoriesWidthState extends State<CategoriesWidth> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "SubCategories",
              arguments: widget.gridText);
        },
        child: Container(
          padding: const EdgeInsets.only(right: 10),
          height: 250,
          width: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(widget.gridimgpath),
            ),
            borderRadius: BorderRadius.circular(20),
            color: themeState.getDarkTheme
                ? const Color(0xFF335171)
                : Colors.white,
          ),
        ),
      ),
    );
  }
}
