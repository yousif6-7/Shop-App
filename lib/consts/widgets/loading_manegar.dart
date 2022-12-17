import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingManegar extends StatelessWidget {
  const LoadingManegar({Key? key, required this.isLoading, required this.child})
      : super(key: key);
  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
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
