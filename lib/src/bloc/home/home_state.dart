part of 'home_bloc.dart';

abstract class HomeState extends Equatable {}

class UnAuthenticated extends HomeState {
  @override
  List<Object?> get props => [];
}

/// success home product state

class SuccessHomeProductState extends HomeState {
  final List<HomeProductModel> data;

  SuccessHomeProductState(this.data);

  @override
  List<Object?> get props => [data];
}

/// error home product state

class ErrorHomeProductState extends HomeState {
  final String msg;

  ErrorHomeProductState(this.msg);

  @override
  List<Object?> get props => [msg];
}

/// loading home product state

class LoadingHomeProductState extends HomeState {
  @override
  List<Object?> get props => [];
}

/// success add product state

class SuccessAddProductState extends HomeState {
  final bool add;

  SuccessAddProductState(this.add);

  @override
  List<Object?> get props => [add];
}

/// success count product state

class PlusCountProductState extends HomeState {
  final int count;

  PlusCountProductState(this.count);

  @override
  List<Object?> get props => [count];
}

/// success count product state

class MinusCountProductState extends HomeState {
  final int count;
  final bool add;

  MinusCountProductState(this.count, this.add);

  @override
  List<Object?> get props => [count, add];
}

/// success add product state

class SuccessAddLikeState extends HomeState {
  final bool like;

  SuccessAddLikeState(this.like);

  @override
  List<Object?> get props => [like];
}
