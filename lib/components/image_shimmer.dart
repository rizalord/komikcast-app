import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageShimmerPlaceHolder extends StatelessWidget {
  ImageShimmerPlaceHolder({this.width, this.height});

  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          Colors.grey.withOpacity(.5),
          Colors.white,
          Colors.grey.withOpacity(.5),
        ],
        stops: [.4, .5, .6],
        begin: Alignment(-1, -1),
        end: Alignment(1, 1),
      ),
      period: Duration(seconds: 2),
      child: Container(
        width: width,
        height: height,
        color: Colors.grey.withOpacity(.5),
      ),
    );
  }
}
