import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_shopping/src/bloc/category/category_bloc.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';

class CategoryDialog extends StatefulWidget {
  final String selected;
  final Function(String data) onTap;

  const CategoryDialog({
    Key? key,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  List<String> data = [];

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    double width = MediaQuery.of(context).size.width;
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {},
      child:
          BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
        bool loading = state is LoadingCategoryState;
        if (state is SuccessCategoryState) {
          data = state.data;
        }
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: width,
          decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Container(
                      height: 4 * h,
                      width: 50 * w,
                      margin: EdgeInsets.only(top: 8 * h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 16 * h),
                    Text(
                      "Tanlang",
                      style: TextStyle(
                        fontFamily: AppColor.fontFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 18 * h,
                        color: AppColor.black,
                      ),
                    ),
                    Container(
                      height: h,
                      width: width,
                      margin: EdgeInsets.only(top: 16 * h),
                      color: AppColor.black.withOpacity(0.1),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 24 * h, bottom: 8 * h),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              widget.onTap(data[index]);
                              Navigator.pop(context);
                            },
                            child: Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.symmetric(vertical: 8 * h),
                              margin: EdgeInsets.only(
                                bottom: 16 * h,
                                left: 20 * w,
                                right: 20 * w,
                              ),
                              child: Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    height: 20 * h,
                                    width: 20 * h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: AppColor.white,
                                      border: Border.all(
                                        color: widget.selected == data[index]
                                            ? AppColor.blue
                                            : AppColor.black.withOpacity(0.5),
                                      ),
                                    ),
                                    child: Center(
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                        height: 10 * h,
                                        width: 10 * h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: widget.selected == data[index]
                                              ? AppColor.blue
                                              : AppColor.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16 * w),
                                  Text(
                                    data[index],
                                    style: TextStyle(
                                      fontFamily: AppColor.fontFamily,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16 * h,
                                      letterSpacing: w,
                                      color: AppColor.blue,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(width: 8 * w),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        );
      }),
    );
  }

  void _getData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<CategoryBloc>(context).add(
        AllCategoryEvent(),
      );
    });
  }
}
