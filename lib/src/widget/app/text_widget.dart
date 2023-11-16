import 'package:flutter/material.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final EdgeInsets margin;
  final int fontSize;
  final FontWeight fontWeight;
  final double spacing;
  final double height;
  final Color color;
  final int? maxLines;
  final TextAlign? align;

  const TextWidget({
    Key? key,
    required this.text,
    this.margin = EdgeInsets.zero,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w700,
    this.spacing = 0.5,
    this.height = 0,
    this.color = AppColor.black,
    this.maxLines,
    this.align,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Container(
      color: Colors.transparent,
      margin: margin,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: AppColor.fontFamily,
          fontWeight: fontWeight,
          fontSize: fontSize * h,
          letterSpacing: spacing * w,
          color: color,
          height: height,
        ),
        textAlign: align ?? TextAlign.center,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
