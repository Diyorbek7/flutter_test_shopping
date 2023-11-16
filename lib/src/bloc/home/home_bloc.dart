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
      await dataBase.saveCart(
        HomeProductModel(
          id: event.data.id,
          title: event.data.title,
          price: event.data.price,
          description: event.data.description,
          category: event.data.category,
          image: event.data.image,
          rating: event.data.rating,
          priceCount: k,
        ),
      );
      emit(PlusCountProductState(k));
    });

    /// count minus product

    on<ProductMinusCountEvent>((event, emit) async {
      emit(UnAuthenticated());
      int k = event.count;
      if (k > 1) {
        k--;
        await dataBase.updateCart(
          HomeProductModel(
            id: event.data.id,
            title: event.data.title,
            price: event.data.price,
            description: event.data.description,
            category: event.data.category,
            image: event.data.image,
            rating: event.data.rating,
            priceCount: k,
          ),
        );
        emit(MinusCountProductState(k, true));
      } else {
        await dataBase.deleteCart(event.data.id);
        emit(MinusCountProductState(0, false));
      }
    });

    /// cart all product
    on<CartProductEvent>((event, emit) async {
      emit(LoadingCartAllState());
      List<HomeProductModel> response = await repositoryHome.product();
      double price = 0;
      int count = 0;
      bool add = false;
      for (int i = 0; i < response.length; i++) {
        price += (response[i].price * response[i].priceCount);
      }
      for (int i = 0; i < response.length; i++) {
        if (event.id == response[i].id) {
          count = response[i].priceCount;
          count != 0 ? add = true : add = false;
        }
      }
      emit(
        SuccessCartAllState(
          response,
          price,
          add,
          count,
        ),
      );
    });
  }
}
