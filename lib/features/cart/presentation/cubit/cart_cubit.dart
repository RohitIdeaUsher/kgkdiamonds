import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgkdiamonds/core/models/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/cart_summery.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial()) {
    _loadCart();
  }
  List<DataModel> cartItems = [];

  Future<void> _loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString('cart');

      if (cartJson != null) {
        final List<dynamic> decodedData = jsonDecode(cartJson);
        cartItems = decodedData.map((e) => DataModel.fromJson(e)).toList();
      }
      emit(CartLoaded(cartItems, _calculateSummary()));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  void addToCart(DataModel diamond) async {
    cartItems.add(diamond);
    await _saveCart();
    emit(CartLoaded(cartItems, _calculateSummary()));
  }

  void removeFromCart(int diamondId) async {
    cartItems.removeWhere((item) => item.lotID == diamondId);
    await _saveCart();
    emit(CartLoaded(cartItems, _calculateSummary()));
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = jsonEncode(cartItems.map((e) => e.toJson()).toList());
    await prefs.setString('cart', cartJson);
  }

  CartSummary _calculateSummary() {
    double totalCarat = 0.0;
    double totalPrice = 0.0;
    double totalDiscount = 0.0;

    for (var diamond in cartItems) {
      totalCarat += diamond.carat ?? 0.0;
      totalPrice += diamond.finalAmount ?? 0.0;
      totalDiscount += diamond.discount ?? 0.0;
    }

    return CartSummary(
      totalCarat: totalCarat,
      totalPrice: totalPrice,
      avgPrice: cartItems.isNotEmpty ? totalPrice / cartItems.length : 0.0,
      avgDiscount:
          cartItems.isNotEmpty ? totalDiscount / cartItems.length : 0.0,
    );
  }
}
