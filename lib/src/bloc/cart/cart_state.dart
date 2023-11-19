part of 'cart_bloc.dart';

abstract class CartState extends Equatable {}

class UnAuthenticated extends CartState {
  @override
  List<Object?> get props => [];
}

/// success cart user state

class SuccessCartUserState extends CartState {
  final List<CartUserModel> data;
  final List<AllUserModel> dataAllUser;

  SuccessCartUserState(this.data, this.dataAllUser);

  @override
  List<Object?> get props => [data, dataAllUser];
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

/// success user state

class SuccessUserState extends CartState {
  final UserModel data;

  SuccessUserState(this.data);

  @override
  List<Object?> get props => [data];
}

/// error user state

class ErrorUserState extends CartState {
  final String msg;

  ErrorUserState(this.msg);

  @override
  List<Object?> get props => [msg];
}

/// loading user state

class LoadingUserState extends CartState {
  @override
  List<Object?> get props => [];
}

/// success all user state

class SuccessAllUserState extends CartState {
  final List<AllUserModel> data;

  SuccessAllUserState(this.data);

  @override
  List<Object?> get props => [data];
}

/// error all user state

class ErrorAllUserState extends CartState {
  final String msg;

  ErrorAllUserState(this.msg);

  @override
  List<Object?> get props => [msg];
}

/// loading all user state

class LoadingAllUserState extends CartState {
  @override
  List<Object?> get props => [];
}
