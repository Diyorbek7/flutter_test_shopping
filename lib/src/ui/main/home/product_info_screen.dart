import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_shopping/src/bloc/home/home_bloc.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/model/home/home_product_model.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:flutter_test_shopping/src/widget/app/appbar_widget.dart';
import 'package:flutter_test_shopping/src/widget/app/button_widget.dart';
import 'package:flutter_test_shopping/src/widget/app/text_widget.dart';
import 'package:flutter_test_shopping/src/widget/product/add_widget.dart';
import 'package:flutter_test_shopping/src/widget/product/product_info_widget.dart';

class ProductInfoScreen extends StatefulWidget {
  final HomeProductModel data;
  final int id;

  const ProductInfoScreen({
    super.key,
    required this.data,
    required this.id,
  });

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  bool add = false;
  int count = 0;

  List<HomeProductModel> data = [];

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: appBarNoActionWidget(context, widget.data.title),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          bool loading = state is LoadingCartAllState;
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
          } else if (state is SuccessCartAllState) {
            data = state.data;
            count = state.count;
            add = state.add;
          }
          return loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ProductInfoWidget(data: widget.data),
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
                                  ProductAddEvent(true, widget.data),
                                );
                              },
                              color: AppColor.blue,
                              splashColor: AppColor.dark,
                              widget: const Center(
                                child: TextWidget(
                                  text: "Add",
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  void _getData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(
        CartProductEvent(widget.id),
      );
    });
  }
}
