import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_shopping/src/bloc/home/home_bloc.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/database/database_helper.dart';
import 'package:flutter_test_shopping/src/model/home/home_product_model.dart';
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
  List<HomeProductModel> data = [];
  double price = 0;
  DatabaseHelper dataBase = DatabaseHelper();

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        bool loading = state is LoadingCartAllState;
        if (state is SuccessCartAllState) {
          data = state.data;
          price = state.price;
        } else if (state is MinusCountProductState) {
          _getData();
        }
        return Scaffold(
          appBar: appBarOnlyText(context, "Cart"),
          body: loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : data.isEmpty
                  ? const Center(
                      child: TextWidget(
                        text: "Mahsulotlar yo'q",
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.only(
                              left: 20 * w,
                              top: 8 * h,
                              right: 20 * w,
                              bottom: 20 * h,
                            ),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return CartWidget(
                                data: data[index],
                                onTap: () {
                                  BlocProvider.of<HomeBloc>(context).add(
                                    ProductMinusCountEvent(
                                      0,
                                      false,
                                      data[index],
                                    ),
                                  );
                                },
                              );
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
                              text:
                                  "Total price: ${price.toStringAsFixed(2)}\$",
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ],
                    ),
        );
      },
    );
  }

  void _getData() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<HomeBloc>(context).add(
          CartProductEvent(0),
        );
      },
    );
  }
}
