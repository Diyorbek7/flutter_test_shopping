import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:flutter_test_shopping/src/widget/app/text_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CenterDialog {
  static void showCustom(
    BuildContext context,
    Color color,
    String title,
    String text,
  ) {
    double h = Utils.height(context);
    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      padding: EdgeInsets.all(12 * h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
        boxShadow: [
          BoxShadow(
            offset: const Offset(
              0,
              4,
            ),
            blurRadius: 4,
            color: AppColor.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: title,
                  maxLines: 2,
                  align: TextAlign.left,
                ),
                SizedBox(height: 8 * h),
                TextWidget(
                  text: text,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  maxLines: 2,
                  align: TextAlign.left,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              fToast.removeCustomToast();
            },
            child: Container(
              height: 24 * h,
              width: 24 * h,
              color: Colors.transparent,
              child: SvgPicture.asset(
                "assets/icons/cancel.svg",
                height: 24 * h,
                width: 24 * h,
              ),
            ),
          ),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 2),
      gravity: ToastGravity.TOP,
      fadeDuration: const Duration(milliseconds: 350),
    );
  }
}
