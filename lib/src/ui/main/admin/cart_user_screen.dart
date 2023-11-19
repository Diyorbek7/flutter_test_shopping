import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_shopping/src/bloc/cart/cart_bloc.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/dialog/center/center_dialog.dart';
import 'package:flutter_test_shopping/src/model/cart/cart_model.dart';
import 'package:flutter_test_shopping/src/model/user/all_user_model.dart';
import 'package:flutter_test_shopping/src/repository/cart/cart_repository.dart';
import 'package:flutter_test_shopping/src/ui/main/admin/user_all_info_screen.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:flutter_test_shopping/src/widget/app/appbar_widget.dart';
import 'package:flutter_test_shopping/src/widget/app/button_widget.dart';
import 'package:flutter_test_shopping/src/widget/app/text_widget.dart';
import 'package:flutter_test_shopping/src/widget/cart/cart_info_widget.dart';

class CartUserScreen extends StatefulWidget {
  const CartUserScreen({super.key});

  @override
  State<CartUserScreen> createState() => _CartUserScreenState();
}

class _CartUserScreenState extends State<CartUserScreen> {
  List<CartUserModel> data = [];
  List<AllUserModel> dataAllUser = [];

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is ErrorCartUserState) {
          CenterDialog.showCustom(
            context,
            AppColor.red,
            "Error",
            state.msg,
          );
        }
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          bool loading = state is LoadingCartUserState;
          if (state is SuccessCartUserState) {
            data = state.data;
            dataAllUser = state.dataAllUser;
          }
          return Scaffold(
            appBar: appBarNoActionWidget(context, "User cart"),
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
                    : ListView.separated(
                        padding: EdgeInsets.only(
                          left: 20 * w,
                          top: 8 * h,
                          right: 20 * w,
                          bottom: Platform.isIOS ? 40 : 32 * h,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(16 * h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColor.black.withOpacity(0.1),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CartInfoWidget(
                                  title: "ID:",
                                  text: data[index].id.toString(),
                                ),
                                CartInfoWidget(
                                  title: "Username:",
                                  text: dataAllUser[data[index].userId - 1]
                                      .username,
                                ),
                                CartInfoWidget(
                                  title: "Date:",
                                  text:
                                      Utils.getDateHourFormat(data[index].date),
                                ),
                                data[index].products.isEmpty
                                    ? Container()
                                    : const CartInfoWidget(
                                        title: "Products",
                                        text: "",
                                      ),
                                ListView.separated(
                                  itemCount: data[index].products.length,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, pc) {
                                    return Container(
                                      padding: EdgeInsets.all(8 * h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: AppColor.gray,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CartInfoWidget(
                                            title: "Product ID:",
                                            text: data[index]
                                                .products[pc]
                                                .productId
                                                .toString(),
                                          ),
                                          CartInfoWidget(
                                            title: "PC:",
                                            text:
                                                "${data[index].products[pc].quantity} pc",
                                            last: true,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 4 * h);
                                  },
                                ),
                                ButtonWidget(
                                  height: 48 * h,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return RepositoryProvider(
                                            create: (context) =>
                                                CartRepository(),
                                            child: BlocProvider(
                                              create: (context) => CartBloc(
                                                repositoryCart:
                                                    RepositoryProvider.of<
                                                            CartRepository>(
                                                        context),
                                              ),
                                              child: UserAllInfoScreen(
                                                username: dataAllUser[
                                                        data[index].userId - 1]
                                                    .username,
                                                id: data[index].userId,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  widget: const Center(
                                    child: TextWidget(text: "User all info"),
                                  ),
                                  margin: EdgeInsets.only(top: 12 * h),
                                  color: AppColor.shimmerBaseColor,
                                  splashColor: AppColor.black,
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 12 * h);
                        },
                      ),
          );
        },
      ),
    );
  }

  void _getData() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<CartBloc>(context).add(
          CartAllUserEvent(),
        );
      },
    );
  }
}
