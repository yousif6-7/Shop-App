import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../consts/widgets.dart';
import '../product_det_screen.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({Key? key}) : super(key: key);

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.maxFinite,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductDetScreen()),
              );
            },
            child: Container(
              width: 180,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/home/homeimg1.jpeg"),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusibleText(
                text: 'Item name x12',
                size: 20,
                textfontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 10,
              ),
              ReusibleText(
                text: 'Paid: \$100',
                size: 16,
                textfontWeight: FontWeight.w600,
              ),
              SizedBox(height: 5,),

              ReusibleText(
                text: '22/4/2022',
                size: 16,
                textfontWeight: FontWeight.w600,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
