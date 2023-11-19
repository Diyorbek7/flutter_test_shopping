import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_shopping/src/database/database_helper.dart';
import 'package:flutter_test_shopping/src/model/cart/cart_model.dart';
import 'package:flutter_test_shopping/src/model/http_result.dart';
import 'package:flutter_test_shopping/src/model/user/all_user_model.dart';
import 'package:flutter_test_shopping/src/model/user/user_model.dart';
import 'package:flutter_test_shopping/src/repository/cart/cart_repository.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final RepositoryCart repositoryCart;
  DatabaseHelper dataBase = DatabaseHelper();

  CartBloc({
    required this.repositoryCart,
  }) : super(UnAuthenticated()) {
    /// cart user
    on<CartAllUserEvent>((event, emit) async {
      emit(LoadingCartUserState());
      HttpResult response = await repositoryCart.cartUser();
      if (response.isSuccess) {
        HttpResult responseAllUser = await repositoryCart.allUser();
        List<CartUserModel> data = cartUserModelFromJson(
          json.encode(response.result),
        );
        if (responseAllUser.isSuccess) {
          List<AllUserModel> dataAllUser = allUserModelFromJson(
            json.encode(responseAllUser.result),
          );
          emit(SuccessCartUserState(data, dataAllUser));
        }
      } else if (response.status == -1) {
        emit(ErrorCartUserState("Network error"));
      } else if (response.status == -2) {
        emit(ErrorCartUserState("Server Error"));
      } else {
        emit(ErrorCartUserState(Utils.errorMessage(response)));
      }
    });

    /// user
    on<UserEvent>((event, emit) async {
      emit(LoadingUserState());
      HttpResult response = await repositoryCart.user(event.id);
      if (response.isSuccess) {
        UserModel data = UserModel.fromJson(response.result);
        emit(SuccessUserState(data));
      } else if (response.status == -1) {
        emit(ErrorUserState("Network error"));
      } else if (response.status == -2) {
        emit(ErrorUserState("Server Error"));
      } else {
        emit(ErrorUserState(Utils.errorMessage(response)));
      }
    });

    /// all user
    on<CartUsersEvent>((event, emit) async {
      emit(LoadingAllUserState());
      HttpResult response = await repositoryCart.allUser();
      if (response.isSuccess) {
        List<AllUserModel> data = allUserModelFromJson(
          json.encode(response.result),
        );
        emit(SuccessAllUserState(data));
      } else if (response.status == -1) {
        emit(ErrorAllUserState("Network error"));
      } else if (response.status == -2) {
        emit(ErrorAllUserState("Server Error"));
      } else {
        emit(ErrorAllUserState(Utils.errorMessage(response)));
      }
    });
  }
}
