import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/database/database_helper.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:flutter_test_shopping/src/widget/app/appbar_widget.dart';
import 'package:flutter_test_shopping/src/widget/app/button_widget.dart';
import 'package:flutter_test_shopping/src/widget/app/text_widget.dart';
import 'package:flutter_test_shopping/src/widget/cart/cart_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final database = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      appBar: appBarNoActionWidget(context, "Cart"),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(
                left: 20 * w,
                top: 8 * h,
                right: 20 * w,
                bottom: 20 * h,
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                return CartWidget();
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 12 * h);
              },
            ),
          ),
          ButtonWidget(
            height: 44 * h,
            onTap: () {},
            color: AppColor.blue,
            margin: EdgeInsets.only(
              left: 20 * w,
              right: 20 * w,
              bottom: Platform.isIOS ? 40 * h : 32 * h,
            ),
            widget: Center(
              child: TextWidget(
                text: "Total price:",
                color: appColor.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
