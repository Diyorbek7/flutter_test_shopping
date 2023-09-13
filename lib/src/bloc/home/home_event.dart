part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// home product event

class HomeProductEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

/// product add event

class ProductAddEvent extends HomeEvent {
  final bool add;

  ProductAddEvent(this.add);

  @override
  List<Object> get props => [add];
}

/// product plus count event

class ProductPlusCountEvent extends HomeEvent {
  final int count;
  final HomeProductModel data;

  ProductPlusCountEvent(this.count, this.data);

  @override
  List<Object> get props => [count, data];
}

/// product minus count event

class ProductMinusCountEvent extends HomeEvent {
  final int count;
  final bool add;
  final HomeProductModel data;

  ProductMinusCountEvent(
    this.count,
    this.add,
    this.data,
  );

  @override
  List<Object> get props => [
        count,
        add,
        data,
      ];
}

/// product add like event

class ProductAddLikeEvent extends HomeEvent {
  final bool like;

  ProductAddLikeEvent(this.like);

  @override
  List<Object> get props => [like];
}
