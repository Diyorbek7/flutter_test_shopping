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
  final HomeProductModel data;

  ProductAddEvent(this.add, this.data);

  @override
  List<Object> get props => [add, data];
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

/// cart product event

class CartProductEvent extends HomeEvent {
  final int id;

  CartProductEvent(this.id);

  @override
  List<Object> get props => [id];
}

/// home category event

class HomeCategoryEvent extends HomeEvent {
  final String category;

  HomeCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}
