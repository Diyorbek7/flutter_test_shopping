import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_shopping/src/bloc/cart/cart_bloc.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/dialog/center/center_dialog.dart';
import 'package:flutter_test_shopping/src/model/user/user_model.dart';
import 'package:flutter_test_shopping/src/widget/app/appbar_widget.dart';
import 'package:flutter_test_shopping/src/widget/user/user_info_widget.dart';

class UserAllInfoScreen extends StatefulWidget {
  final String username;
  final int id;

  const UserAllInfoScreen({
    super.key,
    required this.username,
    required this.id,
  });

  @override
  State<UserAllInfoScreen> createState() => _UserAllInfoScreenState();
}

class _UserAllInfoScreenState extends State<UserAllInfoScreen> {
  UserModel data = UserModel.fromJson({});

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is ErrorUserState) {
          CenterDialog.showCustom(
            context,
            AppColor.red,
            "Error",
            state.msg,
          );
        }
      },
      child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        bool loading = state is LoadingUserState;
        if (state is SuccessUserState) {
          data = state.data;
        }
        return Scaffold(
          appBar: appBarNoActionWidget(
              context, "Information about - ${widget.username}"),
          body: loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : UserInfoWidget(data: data),
        );
      }),
    );
  }

  void _getData() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<CartBloc>(context).add(
          UserEvent(widget.id),
        );
      },
    );
  }
}
