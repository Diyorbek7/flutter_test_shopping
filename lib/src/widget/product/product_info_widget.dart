import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/model/home/home_product_model.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:flutter_test_shopping/src/widget/app/text_widget.dart';
import 'package:flutter_test_shopping/src/widget/product/star_widget.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ProductInfoWidget extends StatelessWidget {
  final HomeProductModel data;

  const ProductInfoWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return ListView(
      padding: EdgeInsets.only(
        left: 20 * w,
        top: 8 * h,
        right: 20 * w,
        bottom: 20 * h,
      ),
      children: [
        CachedNetworkImage(
          height: 220 * h,
          width: MediaQuery.of(context).size.width,
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
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16 * h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextWidget(
                  text: data.title,
                  color: AppColor.dark,
                  fontSize: 20,
                  maxLines: 2,
                  align: TextAlign.left,
                  margin: EdgeInsets.only(right: 8 * w),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: StarWidget(
                count: data.rating.rate,
                size: 16,
              ),
            ),
            Expanded(
              child: TextWidget(
                text:
                    "${translate("home.count")} ${data.rating.count} ${translate("home.ta")}",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColor.dark,
                align: TextAlign.right,
                margin: EdgeInsets.only(left: 12 * w),
              ),
            ),
          ],
        ),
        TextWidget(
          text: "\$${data.price}",
          fontSize: 20,
          color: AppColor.blue,
          margin: EdgeInsets.only(top: 16 * h),
          align: TextAlign.left,
        ),
        TextWidget(
          text: translate("home.desc"),
          fontSize: 20,
          color: AppColor.dark,
          margin: EdgeInsets.symmetric(vertical: 16 * h),
          align: TextAlign.left,
        ),
        TextWidget(
          text: data.description,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColor.dark,
          maxLines: 10,
          align: TextAlign.left,
        ),
      ],
    );
  }
}
