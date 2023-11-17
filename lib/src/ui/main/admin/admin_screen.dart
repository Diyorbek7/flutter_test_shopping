import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_shopping/src/bloc/cart/cart_bloc.dart';
import 'package:flutter_test_shopping/src/repository/cart/cart_repository.dart';
import 'package:flutter_test_shopping/src/ui/main/admin/cart_user_screen.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:flutter_test_shopping/src/widget/app/appbar_widget.dart';
import 'package:flutter_test_shopping/src/widget/app/button_widget.dart';
import 'package:flutter_test_shopping/src/widget/app/text_widget.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      appBar: appBarOnlyText(context, "Admin"),
      body: Column(
        children: [
          ButtonWidget(
            height: 48 * h,
            onTap: () {
              _nextPage();
            },
            widget: Row(
              children: [
                const Expanded(
                  child: TextWidget(
                    text: "User cart",
                    align: TextAlign.left,
                  ),
                ),
                Icon(
                  CupertinoIcons.right_chevron,
                  size: 24 * h,
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 16 * w),
            margin: EdgeInsets.all(24 * h),
          ),
        ],
      ),
    );
  }

  Future<void> _nextPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return RepositoryProvider(
            create: (context) => CartRepository(),
            child: BlocProvider(
              create: (context) => CartBloc(
                repositoryCart: RepositoryProvider.of<CartRepository>(context),
              ),
              child: const CartUserScreen(),
            ),
          );
        },
      ),
    );
  }
}
