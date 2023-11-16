import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:flutter_test_shopping/src/widget/app/text_widget.dart';

AppBar appBarWidget(
  BuildContext context,
  String title,
  String svg,
  Function() onTap,
) {
  double h = Utils.height(context);
  double w = Utils.width(context);
  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: AppColor.white,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
    leading: Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: 24 * h,
          width: 24 * h,
          color: Colors.transparent,
          child: Center(
            child: SvgPicture.asset(
              "assets/icons/back.svg",
              height: 20 * h,
              width: 20 * h,
            ),
          ),
        ),
      ),
    ),
    title: TextWidget(
      text: title,
      fontWeight: FontWeight.w700,
      fontSize: 22,
      color: AppColor.black,
    ),
    actions: [
      GestureDetector(
        onTap: onTap,
        child: Center(
          child: Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(right: 20 * w),
            child: SvgPicture.asset(
              "assets/icons/$svg.svg",
              height: 20 * h,
              width: 20 * h,
            ),
          ),
        ),
      ),
    ],
  );
}

AppBar appBarOnlyText(
  BuildContext context,
  String text,
) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: AppColor.white,
    leadingWidth: 0,
    leading: Container(),
    title: TextWidget(
      text: text,
      fontWeight: FontWeight.w700,
      fontSize: 22,
      spacing: 0,
      color: AppColor.black,
    ),
  );
}

AppBar appBarNoActionWidget(
  BuildContext context,
  String title,
) {
  double h = Utils.height(context);
  return AppBar(
    elevation: 0,
    centerTitle: false,
    backgroundColor: AppColor.white,
    leading: Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: 24 * h,
          width: 24 * h,
          color: Colors.transparent,
          child: Center(
            child: SvgPicture.asset(
              "assets/icons/back.svg",
            ),
          ),
        ),
      ),
    ),
    title: TextWidget(
      text: title,
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: AppColor.dark,
      spacing: 0,
      align: TextAlign.left,
    ),
  );
}
