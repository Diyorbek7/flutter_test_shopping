import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_shopping/src/bloc/home/home_bloc.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/dialog/bottom/bottom_dialog.dart';
import 'package:flutter_test_shopping/src/dialog/center/center_dialog.dart';
import 'package:flutter_test_shopping/src/model/home/home_product_model.dart';
import 'package:flutter_test_shopping/src/repository/home/home_repository.dart';
import 'package:flutter_test_shopping/src/ui/main/home/product_info_screen.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:flutter_test_shopping/src/widget/app/appbar_widget.dart';
import 'package:flutter_test_shopping/src/widget/product/product_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HomeProductModel> data = [];
  int itemCount = 2;
  String selected = "";

  @override
  void initState() {
    _getData(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is ErrorHomeProductState) {
          CenterDialog.showCustom(
            context,
            AppColor.red,
            "Error",
            state.msg,
          );
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          bool loading = state is LoadingHomeProductState;
          if (state is SuccessHomeProductState) {
            data = state.data;
          }
          return Scaffold(
            backgroundColor: AppColor.white,
            appBar: appBarWidget(
              context,
              "Product",
              "filter",
              () {
                BottomDialog.showCategoryDialog(
                  context,
                  selected,
                  (type) {
                    selected = type;
                    _getData(true);
                  },
                );
              },
            ),
            body: loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.only(
                      left: 20 * w,
                      top: 20 * h,
                      right: 20 * w,
                      bottom: Platform.isIOS ? 40 * h : 32 * h,
                    ),
                    itemCount: (data.length + itemCount - 1) ~/ itemCount,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: ProductWidget(
                              onTap: () {
                                _nextPage(
                                  data[index * itemCount],
                                  data[index * itemCount].id,
                                );
                              },
                              data: data[index * itemCount],
                            ),
                          ),
                          SizedBox(width: 12 * w),
                          Expanded(
                            child: index * itemCount + 1 >= data.length
                                ? Container()
                                : ProductWidget(
                                    onTap: () {
                                      _nextPage(
                                        data[index * itemCount + 1],
                                        data[index * itemCount + 1].id,
                                      );
                                    },
                                    data: data[index * itemCount + 1],
                                  ),
                          ),
                        ],
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

  void _getData(bool category) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(
        category ? HomeCategoryEvent(selected) : HomeProductEvent(),
      );
    });
  }

  Future<void> _nextPage(all, int index) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return RepositoryProvider(
            create: (context) => HomeRepository(),
            child: BlocProvider(
              create: (context) => HomeBloc(
                repositoryHome: RepositoryProvider.of<HomeRepository>(context),
              ),
              child: ProductInfoScreen(
                data: all,
                id: index,
              ),
            ),
          );
        },
      ),
    );
  }
}
