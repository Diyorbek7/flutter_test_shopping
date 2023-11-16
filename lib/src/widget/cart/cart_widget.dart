import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/model/home/home_product_model.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:flutter_test_shopping/src/widget/app/text_widget.dart';

class CartWidget extends StatelessWidget {
  final HomeProductModel data;
  final Function() onTap;

  const CartWidget({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Container(
      padding: EdgeInsets.all(20 * h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.white,
        border: Border.all(
          color: AppColor.gray,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              height: 72 * h,
              width: 72 * h,
              imageUrl: data.image,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(width: 12 * w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                        text: data.title,
                        margin: EdgeInsets.only(top: 8 * h),
                        color: AppColor.dark,
                        maxLines: 2,
                        align: TextAlign.left,
                      ),
                    ),
                    SizedBox(width: 8 * w),
                    IconButton(
                      onPressed: onTap,
                      icon: SvgPicture.asset(
                        "assets/icons/trash.svg",
                        height: 24 * h,
                        width: 24 * h,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextWidget(
                        text: "\$${data.price}",
                        margin: EdgeInsets.only(top: 8 * h),
                        color: AppColor.blue,
                        align: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      child: TextWidget(
                        text: "${data.priceCount} ta",
                        margin: EdgeInsets.only(top: 8 * h),
                        color: AppColor.dark,
                        align: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
