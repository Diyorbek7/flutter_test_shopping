import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_shopping/src/model/category/category_model.dart';
import 'package:flutter_test_shopping/src/model/http_result.dart';
import 'package:flutter_test_shopping/src/repository/category/category_repository.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final RepositoryCategory repositoryCategory;

  CategoryBloc({
    required this.repositoryCategory,
  }) : super(UnAuthenticated()) {
    /// category
    on<AllCategoryEvent>(
      (event, emit) async {
        emit(LoadingCategoryState());
        HttpResult response = await repositoryCategory.allCategory();
        if (response.isSuccess) {
          List<String> data =
              categoryModelFromJson(json.encode(response.result));
          if (data.isNotEmpty) {
            emit(SuccessCategoryState(data));
          } else {
            emit(ErrorCategoryState(Utils.errorMessage(response)));
          }
        } else if (response.status == -1) {
          emit(ErrorCategoryState("Network error"));
        } else if (response.status == -2) {
          emit(ErrorCategoryState("Server error"));
        } else {
          emit(ErrorCategoryState(Utils.errorMessage(response)));
        }
      },
    );
  }
}
