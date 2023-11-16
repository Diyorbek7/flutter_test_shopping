part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {}

class UnAuthenticated extends CategoryState {
  @override
  List<Object?> get props => [];
}

/// success category state

class SuccessCategoryState extends CategoryState {
  final List<String> data;

  SuccessCategoryState(this.data);

  @override
  List<Object?> get props => [data];
}

/// error category state

class ErrorCategoryState extends CategoryState {
  final String msg;

  ErrorCategoryState(this.msg);

  @override
  List<Object?> get props => [msg];
}

/// loading category state

class LoadingCategoryState extends CategoryState {
  @override
  List<Object?> get props => [];
}
