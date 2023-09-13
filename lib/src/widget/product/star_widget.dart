import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';

class StarWidget extends StatelessWidget {
  final double count;
  final double size;

  const StarWidget({
    Key? key,
    required this.count,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Row(
      children: [
        SvgPicture.asset(
          count >= 1 ? "assets/icons/star.svg" : "assets/icons/unstar.svg",
          height: size * h,
          width: size * h,
        ),
        SizedBox(
          width: 4 * w,
        ),
        SvgPicture.asset(
          count >= 2 ? "assets/icons/star.svg" : "assets/icons/unstar.svg",
          height: size * h,
          width: size * h,
        ),
        SizedBox(
          width: 4 * w,
        ),
        SvgPicture.asset(
          count >= 3 ? "assets/icons/star.svg" : "assets/icons/unstar.svg",
          height: size * h,
          width: size * h,
        ),
        SizedBox(
          width: 4 * w,
        ),
        SvgPicture.asset(
          count >= 4 ? "assets/icons/star.svg" : "assets/icons/unstar.svg",
          height: size * h,
          width: size * h,
        ),
        SizedBox(
          width: 4 * w,
        ),
        SvgPicture.asset(
          count >= 5 ? "assets/icons/star.svg" : "assets/icons/unstar.svg",
          height: size * h,
          width: size * h,
        ),
      ],
    );
  }
}
