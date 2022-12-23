import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/widgets/indecator.dart';

import '../../consts/widgets.dart';
import '../../models/orders_models.dart';
import '../../models/producys_models.dart';
import '../../providers/models_provider.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({Key? key}) : super(key: key);

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  late String DateToShow;

  @override
  void didChangeDependencies() {
    final ordersModel = Provider.of<OrdersModel>(context);
    var orderDate = ordersModel.orderDate.toDate();
    DateToShow =
        '${orderDate.day}/${orderDate.month}/${orderDate.year} at ${orderDate.hour}:${orderDate.minute}';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ordersModel = Provider.of<OrdersModel>(context);
    final productProviders = Provider.of<ProductProvider>(context);
    final ProductModels getCurrentProduct =
        productProviders.findProductById(ordersModel.productId);

    double paidPrice = double.parse(getCurrentProduct.price.toString()) *
        int.parse(ordersModel.quantity.toString());
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.maxFinite,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "ProductDetScreen",
                  arguments: getCurrentProduct.id);
            },
            child: Container(
              width: 160,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // image: DecorationImage(
                //   fit: BoxFit.cover,
                //   image: NetworkImage(ordersModel.orderimageUrl),
                // ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: getCurrentProduct.imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    alignment: Alignment.center,
                    child: const Indecator(isLoading: true),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${getCurrentProduct.title} X ${ordersModel.quantity}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  color: Color(0xFF00264D),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ReusableText(
                text: 'Paid: iq $paidPrice',
                size: 16,
                textfontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 5,
              ),
              ReusableText(
                text: 'address: ${ordersModel.address}',
                size: 15,
                textfontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: 'Phone number:',
                    size: 15,
                    textfontWeight: FontWeight.w600,
                  ),
                  ReusableText(
                    text: ' ${ordersModel.phoneNumber.toString()}',
                    size: 15,
                    textfontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              ReusableText(
                text: 'Date and time:',
                size: 15,
                textfontWeight: FontWeight.w600,
              ),
              ReusableText(
                text: DateToShow,
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
