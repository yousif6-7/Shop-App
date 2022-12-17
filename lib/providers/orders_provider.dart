import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../consts/firebase_const.dart';
import '../models/orders_models.dart';
import '../services/methods.dart';

class OrdersProvider with ChangeNotifier {
  Map<String, OrdersModel> orders = {};

  Map<String, OrdersModel> get getOrderItems {
    return orders;
  }

  Future<void> addToorder({
    required String productName,
    required String orderId,
    required String address,
    required String userId,
    required String productid,
    required String price,
    required String imageUrl,
    required String totalPrice,
    required String? userName,
    required int quantity,
    required Timestamp time,
    required String phoneNumber,
    required context,
  }) async {
    final User? user = authInstance.currentUser;
    final uid = user!.uid;
    try {
      FirebaseFirestore.instance.collection('orders').doc(uid).update({
        'orders': FieldValue.arrayUnion([
          {
            'orderId': orderId,
            'userId': userId,
            'productId': productid,
            'price': price,
            'totalPrice': totalPrice.toString(),
            'quantity': quantity.toString(),
            'imageUrl': imageUrl,
            'userName': userName,
            'orderDate': time,
            'address': address,
            'productName': productName,
            'phoneNumber': phoneNumber,
          }
        ])
      });
      await Fluttertoast.showToast(
          msg: 'Item has been add to orders',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    } catch (e) {
      return Methods.ErrorDailog(subtitle: e.toString(), context: context);
    }
  }






  final userCollection = FirebaseFirestore.instance.collection('orders');

  Future<void> fetchOrders() async {
    final User? user = authInstance.currentUser;

    final DocumentSnapshot userDocs = await userCollection.doc(user!.uid).get();
    if (userDocs == null) {
      return;
    }
    final leng = userDocs.get('orders').length;
    for (int i = 0; i < leng; i++) {
      orders.putIfAbsent(
        userDocs.get('orders')[i]['productId'],
            () => OrdersModel(
          orderId: userDocs.get('orders')[i]['orderId'],
          userId: userDocs.get('orders')[i]['userId'],
          productId: userDocs.get('orders')[i]['productId'],
          userName: userDocs.get('orders')[i]['userName'],
          quantity: userDocs.get('orders')[i]['quantity'],
          orderDate: userDocs.get('orders')[i]['orderDate'],
          address: userDocs.get('orders')[i]['address'],
          orderprice: userDocs.get('orders')[i]['price'],
          orderimageUrl: userDocs.get('orders')[i]['imageUrl'],
          productName: userDocs.get('orders')[i]['productName'],
          phoneNumber: userDocs.get('orders')[i]['phoneNumber'],
          // id: userDocs.get('user_cart')[i]['cartId'],
          // productid: userDocs.get('user_cart')[i]['productid'],
          // quantity: userDocs.get('user_cart')[i]['quantity'],
        ),
      );
    }
    notifyListeners();
  }
}
