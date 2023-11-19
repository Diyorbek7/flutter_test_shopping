import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_shopping/src/bloc/cart/cart_bloc.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/dialog/center/center_dialog.dart';
import 'package:flutter_test_shopping/src/model/user/all_user_model.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:flutter_test_shopping/src/widget/app/appbar_widget.dart';
import 'package:flutter_test_shopping/src/widget/user/all_user_info_widget.dart';

class AllUserScreen extends StatefulWidget {
  const AllUserScreen({super.key});

  @override
  State<AllUserScreen> createState() => _AllUserScreenState();
}

class _AllUserScreenState extends State<AllUserScreen> {
  List<AllUserModel> data = [];

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
        if (state is ErrorAllUserState) {
          CenterDialog.showCustom(
            context,
            AppColor.red,
            "Error",
            state.msg,
          );
        }
      },
      child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        bool loading = state is LoadingAllUserState;
        if (state is SuccessAllUserState) {
          data = state.data;
        }
        return Scaffold(
          appBar: appBarNoActionWidget(context, "All user"),
          body: loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemCount: data.length,
                  padding: EdgeInsets.only(
                    left: 20 * w,
                    top: 20 * h,
                    right: 20 * w,
                    bottom: Platform.isIOS ? 40 * h : 32 * h,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColor.shimmerBaseColor,
                        ),
                      ),
                      child: AllUserInfoWidget(
                        data: data[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12 * h);
                  },
                ),
        );
      }),
    );
  }

  void _getData() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<CartBloc>(context).add(
          CartUsersEvent(),
        );
      },
    );
  }
}
