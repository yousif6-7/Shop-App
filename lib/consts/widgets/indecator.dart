import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Indecator extends StatelessWidget {
  const Indecator({Key? key, required this.isLoading,})
      : super(key: key);
  final bool isLoading;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        isLoading
            ? Container(
          color: Colors.black.withOpacity(0.7),
        )
            : Container(),
        isLoading
            ? Center(
          child: SpinKitSpinningLines(
            color: Colors.white,
          ),
        )
            : Container(),
      ],
    );
  }
}
