import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgkdiamonds/core/common_cubit/diamonds/diamonds_cubit.dart';
import 'package:kgkdiamonds/core/common_cubit/diamonds/diamonds_state.dart';

import '../../../../core/models/data.dart';
import 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  final DiamondsCubit diamondsCubit;
  FilterCubit(this.diamondsCubit) : super(FilterInitial()) {
    _onLoad();
  }
  List<DataModel> allData = [];
  List<DataModel> filteredList = [];
  Set<double> carat = {};
  Set<String> lab = {};
  Set<String> shape = {};
  Set<String> color = {};
  Set<String> clarity = {};
  double? fromCarat;
  double? toCarat;

  // Set<double> selectedCarat = {};
  Set<String> selectedLab = {};
  Set<String> selectedShape = {};
  Set<String> selectedColor = {};
  Set<String> selectedClarity = {};

  // static FilterCubit get(context) => context.read<FilterCubit>();

  void _onLoad() {
    allData = (diamondsCubit.state as DiamondLoaded).diamondsList;
    carat = SplayTreeSet<double>((a, b) => a.compareTo(b))
      ..addAll(allData.where((d) => d.carat != null).map((d) => d.carat!));

    lab = SplayTreeSet<String>()
      ..addAll(
          allData.where((d) => d.lab?.isNotEmpty ?? false).map((d) => d.lab!));

    shape = SplayTreeSet<String>()
      ..addAll(allData
          .where((d) => d.shape?.isNotEmpty ?? false)
          .map((d) => d.shape!));

    color = SplayTreeSet<String>()
      ..addAll(allData
          .where((d) => d.color?.isNotEmpty ?? false)
          .map((d) => d.color!));

    clarity = SplayTreeSet<String>()
      ..addAll(allData
          .where((d) => d.clarity?.isNotEmpty ?? false)
          .map((d) => d.clarity!));
    emit(FilterLoaded([]));
  }

  void updateSelectedFilter(
      {double? caratFrom,
      double? caratTo,
      String? lab,
      String? shape,
      String? color,
      String? clarity,
      bool fromInput = false}) {
    if (fromInput) {
      fromCarat = caratFrom;
      toCarat = caratTo;
    }
    // if (caratFrom != null) {
    //   fromCarat = caratFrom;
    // }
    // if (caratTo != null) {
    //   toCarat = caratTo;
    // }
    if (lab != null) {
      selectedLab.contains(lab)
          ? selectedLab.remove(lab)
          : selectedLab.add(lab);
    }
    if (shape != null) {
      selectedShape.contains(shape)
          ? selectedShape.remove(shape)
          : selectedShape.add(shape);
    }
    if (color != null) {
      selectedColor.contains(color)
          ? selectedColor.remove(color)
          : selectedColor.add(color);
    }
    if (clarity != null) {
      selectedClarity.contains(clarity)
          ? selectedClarity.remove(clarity)
          : selectedClarity.add(clarity);
    }
    _applyFilter();
  }

  void resetFilters() {
    selectedLab.clear();
    selectedShape.clear();
    selectedColor.clear();
    selectedClarity.clear();
    fromCarat = null;
    toCarat = null;
    filteredList = [];
    emit(FilterUpdated(filteredList, selectedLab, selectedShape, selectedColor,
        selectedClarity));
  }

  void _applyFilter() {
    try {
      emit(FilterLoading());
      if (selectedLab.isEmpty &&
          selectedShape.isEmpty &&
          selectedColor.isEmpty &&
          selectedClarity.isEmpty &&
          fromCarat == null &&
          toCarat == null) {
        filteredList.clear(); // OR use `filteredList = List.from(allData);`
        emit(FilterUpdated(filteredList, selectedLab, selectedShape,
            selectedColor, selectedClarity));
        return;
      }

      // Filter `allData` based on selected filters
      filteredList = allData.where((diamond) {
        if (diamond.carat == null) return false;
        final matchesLab =
            selectedLab.isEmpty || selectedLab.contains(diamond.lab);
        final matchesShape =
            selectedShape.isEmpty || selectedShape.contains(diamond.shape);
        final matchesColor =
            selectedColor.isEmpty || selectedColor.contains(diamond.color);
        final matchesClarity = selectedClarity.isEmpty ||
            selectedClarity.contains(diamond.clarity);
        final matchesCaratRange = (fromCarat == null ||
                (diamond.carat != null && diamond.carat! >= fromCarat!)) &&
            (toCarat == null ||
                (diamond.carat != null && diamond.carat! <= toCarat!));

        return matchesCaratRange &&
            matchesLab &&
            matchesShape &&
            matchesColor &&
            matchesClarity;
      }).toList();
      emit(FilterUpdated(filteredList, selectedLab, selectedShape,
          selectedColor, selectedClarity));
    } catch (e) {
      emit(FilterError(e.toString()));
    }
  }
}
