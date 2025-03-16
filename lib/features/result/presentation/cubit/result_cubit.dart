import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgkdiamonds/features/cart/presentation/cubit/cart_cubit.dart';
import '../../../../core/models/data.dart';
import '../../../../core/models/filter.dart';
import '../../../cart/presentation/cubit/cart_state.dart';
import 'result_state.dart';

class ResultCubit extends Cubit<ResultCubitState> {
  final CartCubit cartCubit;
  final List<DataModel> originalList;
  late StreamSubscription cartSubscription;

  ResultCubit(this.originalList, this.cartCubit) : super(ResultCubitInitial()) {
    // getData();
    currentDisplayList = List<DataModel>.from(originalList);
    cartSubscription = cartCubit.stream.listen((state) {
      if (state is CartLoaded) {
        emit(ResultCubitLoaded(currentDisplayList,
            state.cartList.map((e) => e.lotID ?? 0).toSet()));
        //updateResultList(); // Update results when cart changes
      }
    });
  }

  List<DataModel> currentDisplayList = [];
  Set<int> selectedDiamonds = {};

  void getData({FilterModel? filter}) {
    try {
      log("Result cubit is called.");
      emit(ResultCubitLoading());
      log("getdata is called");

      selectedDiamonds = (cartCubit.state as CartLoaded)
          .cartList
          .map((e) => e.lotID ?? 0)
          .toSet();

      currentDisplayList = List<DataModel>.from(originalList);

      emit(ResultCubitLoaded(currentDisplayList, selectedDiamonds));
    } catch (e) {
      emit(ResultCubitError(e.toString()));
    }
  }

  void priceFilter({bool asc = true}) {
    try {
      log("Result cubit is called.");
      emit(ResultCubitLoading());

      currentDisplayList = List<DataModel>.from(currentDisplayList);
      currentDisplayList.sort(
          (a, b) => (a.finalAmount ?? 0.0).compareTo(b.finalAmount ?? 0.0));

      if (!asc) currentDisplayList = currentDisplayList.reversed.toList();

      emit(ResultCubitLoaded(currentDisplayList, selectedDiamonds));
    } catch (e) {
      emit(ResultCubitError(e.toString()));
    }
  }

  void toggleSelection(DataModel diamond) {
    if (selectedDiamonds.contains(diamond.lotID)) {
      selectedDiamonds.remove(diamond.lotID); // Uncheck
      cartCubit.removeFromCart(diamond.lotID ?? 0);
    } else {
      selectedDiamonds.add(diamond.lotID ?? 0); // Check
      cartCubit.addToCart(diamond);
    }

    emit(ResultCubitLoaded(currentDisplayList, selectedDiamonds));
  }

  void caratFilter({bool asc = true}) {
    try {
      log("Result cubit is called.");
      emit(ResultCubitLoading());

      currentDisplayList = List<DataModel>.from(currentDisplayList);

      currentDisplayList
          .sort((a, b) => (a.carat ?? 0.0).compareTo(b.carat ?? 0.0));

      if (!asc) currentDisplayList = currentDisplayList.reversed.toList();

      emit(ResultCubitLoaded(currentDisplayList, selectedDiamonds));
    } catch (e) {
      emit(ResultCubitError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    cartSubscription.cancel();
    return super.close();
  }
}
