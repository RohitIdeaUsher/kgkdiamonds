import 'package:kgkdiamonds/core/models/data.dart';

import '../../domain/cart_summery.dart';

abstract class CartState {}

class CartInitial extends CartState {
  final List<DataModel> diamondsList;

  CartInitial() : diamondsList = [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<DataModel> cartList;
  final CartSummary summary;
  CartLoaded(this.cartList, this.summary);
}

class CartEmpty extends CartState {
  final String message;
  CartEmpty({this.message = "Add items to your cart."});
}

class CartError extends CartState {
  final String error;
  CartError(this.error);
}
