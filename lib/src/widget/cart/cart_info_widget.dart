import 'package:flutter/material.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/widget/app/text_widget.dart';

class CartInfoWidget extends StatelessWidget {
  final String title;
  final String text;
  final bool last;

  const CartInfoWidget({
    super.key,
    required this.title,
    required this.text,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextWidget(
              text: title,
              color: AppColor.black.withOpacity(0.8),
              align: TextAlign.left,
            ),
          ),
          Expanded(
            child: TextWidget(
              text: text,
              align: TextAlign.left,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
