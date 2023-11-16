import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/model/home/home_product_model.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:flutter_test_shopping/src/widget/app/text_widget.dart';

class ProductWidget extends StatelessWidget {
  final Function() onTap;
  final HomeProductModel data;

  const ProductWidget({
    super.key,
    required this.onTap,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: AppColor.white,
        child: InkWell(
          onTap: onTap,
          splashColor: AppColor.black.withOpacity(0.1),
          highlightColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20 * h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColor.gray,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    height: 112 * h,
                    width: 112 * h,
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
                TextWidget(
                  text: data.title,
                  margin: EdgeInsets.only(top: 8 * h),
                  color: AppColor.dark,
                  maxLines: 2,
                  align: TextAlign.left,
                ),
                TextWidget(
                  text: "\$${data.price}",
                  margin: EdgeInsets.only(top: 8 * h),
                  color: AppColor.blue,
                  align: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
