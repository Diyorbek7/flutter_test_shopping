import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_shopping/src/database/database_helper.dart';
import 'package:flutter_test_shopping/src/model/home/home_product_model.dart';
import 'package:flutter_test_shopping/src/model/http_result.dart';
import 'package:flutter_test_shopping/src/repository/home/home_repository.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RepositoryHome repositoryHome;
  DatabaseHelper dataBase = DatabaseHelper();

  HomeBloc({
    required this.repositoryHome,
  }) : super(UnAuthenticated()) {
    /// home product
    on<HomeProductEvent>(
      (event, emit) async {
        emit(LoadingHomeProductState());
        HttpResult response = await repositoryHome.homeProduct();
        if (response.isSuccess) {
          List<HomeProductModel> data = homeProductModelFromJson(
            json.encode(response.result),
          );
          if (data.isNotEmpty) {
            emit(SuccessHomeProductState(data));
          } else {
            emit(ErrorHomeProductState(Utils.errorMessage(response)));
          }
        } else if (response.status == -1) {
          emit(ErrorHomeProductState(translate("error.network_error")));
        } else if (response.status == -2) {
          emit(ErrorHomeProductState(translate("error.server_error")));
        } else {
          emit(ErrorHomeProductState(Utils.errorMessage(response)));
        }
      },
    );

    /// add product

    on<ProductAddEvent>((event, emit) async {
      emit(UnAuthenticated());
      emit(SuccessAddProductState(event.add));
    });

    /// count plus product

    on<ProductPlusCountEvent>((event, emit) async {
      emit(UnAuthenticated());
      int k = event.count;
      k++;
      emit(PlusCountProductState(k));
    });

    /// count minus product

    on<ProductMinusCountEvent>((event, emit) async {
      emit(UnAuthenticated());
      int k = event.count;
      if (k > 1) {
        k--;
        emit(MinusCountProductState(k, true));
      } else {
        emit(MinusCountProductState(0, false));
      }
    });

    /// add like

    on<ProductAddLikeEvent>((event, emit) async {
      emit(UnAuthenticated());
      emit(SuccessAddLikeState(event.like));
    });
  }
}
