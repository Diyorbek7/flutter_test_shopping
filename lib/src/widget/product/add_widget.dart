import 'package:flutter/material.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:flutter_test_shopping/src/widget/app/text_widget.dart';

class AddWidget extends StatelessWidget {
  final int count;
  final Function() minus;
  final Function() plus;

  const AddWidget({
    super.key,
    required this.count,
    required this.minus,
    required this.plus,
  });

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    return Row(
      children: [
        GestureDetector(
          onTap: minus,
          child: Container(
            height: 44 * h,
            width: 44 * h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColor.blue,
            ),
            child: const Center(
              child: TextWidget(
                text: "-",
                color: AppColor.dark,
              ),
            ),
          ),
        ),
        Expanded(
          child: TextWidget(
            text: "$count",
            fontSize: 20,
            color: AppColor.dark,
          ),
        ),
        GestureDetector(
          onTap: plus,
          child: Container(
            height: 44 * h,
            width: 44 * h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColor.blue,
            ),
            child: const Center(
              child: TextWidget(
                text: "+",
                color: AppColor.dark,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
