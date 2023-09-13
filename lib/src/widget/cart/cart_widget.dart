import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:flutter_test_shopping/src/widget/app/text_widget.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Container(
      padding: EdgeInsets.all(20 * h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: appColor.white,
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
              imageUrl: "",
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
                        text: "Thbajbjhcbkahjdvcj ajbckjabscj c",
                        margin: EdgeInsets.only(top: 8 * h),
                        color: appColor.dark,
                        maxLines: 2,
                        align: TextAlign.left,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 24 * h,
                        width: 24 * h,
                        color: Colors.transparent,
                        child: SvgPicture.asset(
                          "assets/icons/like.svg",
                          height: 24 * h,
                          width: 24 * h,
                        ),
                      ),
                    ),
                    SizedBox(width: 8 * w),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 24 * h,
                        width: 24 * h,
                        color: Colors.transparent,
                        child: SvgPicture.asset(
                          "assets/icons/trash.svg",
                          height: 24 * h,
                          width: 24 * h,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextWidget(
                        text: "\$200",
                        margin: EdgeInsets.only(top: 8 * h),
                        color: AppColor.blue,
                        align: TextAlign.left,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 24 * h,
                        width: 32 * w,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          border: Border.all(
                            color: AppColor.gray,
                          ),
                          color: appColor.white,
                        ),
                        child: Center(
                          child: TextWidget(
                            text: "-",
                            color: appColor.dark,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 24 * h,
                      width: 40 * w,
                      decoration: BoxDecoration(
                        color: AppColor.gray.withOpacity(0.6),
                        border: const Border.symmetric(
                          horizontal: BorderSide(
                            color: AppColor.gray,
                          ),
                        ),
                      ),
                      child: Center(
                        child: TextWidget(
                          text: "5",
                          fontSize: 12,
                          color: appColor.dark,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 24 * h,
                        width: 32 * w,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                          border: Border.all(
                            color: AppColor.gray,
                          ),
                        ),
                        child: Center(
                          child: TextWidget(
                            text: "+",
                            color: appColor.dark,
                          ),
                        ),
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
