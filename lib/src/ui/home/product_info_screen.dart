import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_shopping/src/bloc/home/home_bloc.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/model/home/home_product_model.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:flutter_test_shopping/src/widget/app/appbar_widget.dart';
import 'package:flutter_test_shopping/src/widget/app/button_widget.dart';
import 'package:flutter_test_shopping/src/widget/app/text_widget.dart';
import 'package:flutter_test_shopping/src/widget/product/add_widget.dart';
import 'package:flutter_test_shopping/src/widget/product/star_widget.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ProductInfoScreen extends StatefulWidget {
  final HomeProductModel data;

  const ProductInfoScreen({
    super.key,
    required this.data,
  });

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  bool add = false;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: appColor.white,
      appBar: appBarNoActionWidget(context, widget.data.title),
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is SuccessAddProductState) {
          add = state.add;
          BlocProvider.of<HomeBloc>(context).add(
            ProductPlusCountEvent(count, widget.data),
          );
        } else if (state is PlusCountProductState) {
          count = state.count;
        } else if (state is MinusCountProductState) {
          count = state.count;
          add = state.add;
        } else if (state is SuccessAddLikeState) {
          widget.data.like = state.like;
        }
        return Column(
          children: [
            Expanded(
              child: ListView(
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
                    imageUrl: widget.data.image,
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
                            text: widget.data.title,
                            color: appColor.dark,
                            fontSize: 20,
                            maxLines: 2,
                            align: TextAlign.left,
                            margin: EdgeInsets.only(right: 8 * w),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<HomeBloc>(context).add(
                              ProductAddLikeEvent(!widget.data.like),
                            );
                          },
                          child: Container(
                            height: 28 * h,
                            width: 28 * h,
                            color: Colors.transparent,
                            child: SvgPicture.asset(
                              widget.data.like
                                  ? "assets/icons/love.svg"
                                  : "assets/icons/like.svg",
                              height: 24 * h,
                              width: 24 * h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: StarWidget(
                          count: widget.data.rating.rate,
                          size: 16,
                        ),
                      ),
                      Expanded(
                        child: TextWidget(
                          text:
                              "${translate("home.count")} ${widget.data.rating.count} ${translate("home.ta")}",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: appColor.dark,
                          align: TextAlign.right,
                          margin: EdgeInsets.only(left: 12 * w),
                        ),
                      ),
                    ],
                  ),
                  TextWidget(
                    text: "\$${widget.data.price}",
                    fontSize: 20,
                    color: AppColor.blue,
                    margin: EdgeInsets.only(top: 16 * h),
                    align: TextAlign.left,
                  ),
                  TextWidget(
                    text: translate("home.desc"),
                    fontSize: 20,
                    color: appColor.dark,
                    margin: EdgeInsets.symmetric(vertical: 16 * h),
                    align: TextAlign.left,
                  ),
                  TextWidget(
                    text: widget.data.description,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: appColor.dark,
                    maxLines: 10,
                    align: TextAlign.left,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20 * w,
                right: 20 * w,
                bottom: Platform.isIOS ? 40 * h : 32 * h,
              ),
              child: add
                  ? AddWidget(
                      count: count,
                      minus: () {
                        BlocProvider.of<HomeBloc>(context).add(
                          ProductMinusCountEvent(
                            count,
                            add,
                            widget.data,
                          ),
                        );
                      },
                      plus: () {
                        BlocProvider.of<HomeBloc>(context).add(
                          ProductPlusCountEvent(count, widget.data),
                        );
                      },
                    )
                  : ButtonWidget(
                      height: 44 * h,
                      onTap: () {
                        BlocProvider.of<HomeBloc>(context).add(
                          ProductAddEvent(true),
                        );
                      },
                      color: AppColor.blue,
                      splashColor: appColor.dark,
                      widget: Center(
                        child: TextWidget(
                          text: translate("home.add"),
                        ),
                      ),
                    ),
            ),
          ],
        );
      }),
    );
  }
}
