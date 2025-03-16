import 'package:kgkdiamonds/core/models/data.dart';
import 'package:kgkdiamonds/core/models/diamond_data.dart';

import '../../models/filter.dart';
import 'diamonds_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiamondsCubit extends Cubit<DiamondCubitState> {
  DiamondsCubit() : super(DiamondInitial()) {
    getDiamonds();
  }

  void getDiamonds() {
    try {
      emit(DiamondLoading());
      final list = List.generate(
          rawData.length, (index) => DataModel.fromJson(rawData[index]));
      emit(DiamondLoaded(list));
    } catch (e) {
      emit(DiamondError(e.toString()));
    }
  }

  void filterData(FilterModel filter) {
    try {
      emit(DiamondLoading());
      final list = List.generate(
          rawData.length, (index) => DataModel.fromJson(rawData[index]));
      emit(DiamondLoaded(list));
    } catch (e) {
      emit(DiamondError(e.toString()));
    }
  }
}
