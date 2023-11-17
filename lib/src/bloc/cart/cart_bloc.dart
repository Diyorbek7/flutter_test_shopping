import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_shopping/src/database/database_helper.dart';
import 'package:flutter_test_shopping/src/model/cart/cart_model.dart';
import 'package:flutter_test_shopping/src/model/http_result.dart';
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
    on<CartUserEvent>((event, emit) async {
      emit(LoadingCartUserState());
      HttpResult response = await repositoryCart.cartUser();
      if (response.isSuccess) {
        List<CartUserModel> data = cartUserModelFromJson(
          json.encode(response.result),
        );
        emit(SuccessCartUserState(data));
      } else if (response.status == -1) {
        emit(ErrorCartUserState("Network error"));
      } else if (response.status == -2) {
        emit(ErrorCartUserState("Server Error"));
      } else {
        emit(ErrorCartUserState(Utils.errorMessage(response)));
      }
    });
  }
}
