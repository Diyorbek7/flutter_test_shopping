import 'package:flutter/material.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';

class ButtonWidget extends StatelessWidget {
  final Function() onTap;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double radius;
  final Color color;
  final Color splashColor;
  final Widget widget;
  final bool shadow;
  final double x;
  final double y;
  final double blurRadius;
  final double? height;

  const ButtonWidget({
    Key? key,
    required this.onTap,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.radius = 8,
    this.color = AppColor.gray,
    this.splashColor = AppColor.shimmerBaseColor,
    required this.widget,
    this.shadow = true,
    this.x = 0,
    this.y = 8,
    this.blurRadius = 18,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            if (shadow)
              BoxShadow(
                offset: Offset(x, y),
                blurRadius: blurRadius,
                color: color.withOpacity(0.25),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Material(
            color: color,
            child: InkWell(
              onTap: onTap,
              splashColor: splashColor.withOpacity(0.1),
              highlightColor: Colors.transparent,
              child: Container(
                height: height,
                width: MediaQuery.of(context).size.width,
                padding: padding,
                child: widget,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
