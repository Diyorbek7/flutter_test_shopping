part of 'cart_bloc.dart';

abstract class CartState extends Equatable {}

class UnAuthenticated extends CartState {
  @override
  List<Object?> get props => [];
}

/// success cart user state

class SuccessCartUserState extends CartState {
  final List<CartUserModel> data;

  SuccessCartUserState(this.data);

  @override
  List<Object?> get props => [data];
}

/// error cart user state

class ErrorCartUserState extends CartState {
  final String msg;

  ErrorCartUserState(this.msg);

  @override
  List<Object?> get props => [msg];
}

/// loading cart user state

class LoadingCartUserState extends CartState {
  @override
  List<Object?> get props => [];
}
