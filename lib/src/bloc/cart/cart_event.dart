part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// cart all user event

class CartAllUserEvent extends CartEvent {
  @override
  List<Object> get props => [];
}

/// cart user event

class UserEvent extends CartEvent {
  final int id;

  UserEvent(this.id);

  @override
  List<Object> get props => [id];
}

/// cart users event

class CartUsersEvent extends CartEvent {
  @override
  List<Object> get props => [];
}
