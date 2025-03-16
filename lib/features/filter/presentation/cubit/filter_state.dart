import '../../../../core/models/data.dart';

abstract class FilterState {}

class FilterInitial extends FilterState {}

class FilterLoading extends FilterState {}

class FilterLoaded extends FilterState {
  final List<DataModel> filteredList;
  FilterLoaded(this.filteredList);
}

class FilterUpdated extends FilterState {
  final List<DataModel> filteredList;
  Set<String> selectedLab = {};
  Set<String> selectedShape = {};
  Set<String> selectedColor = {};
  Set<String> selectedClarity = {};
  FilterUpdated(this.filteredList, this.selectedLab, this.selectedShape,
      this.selectedColor, this.selectedClarity);
}

class FilterError extends FilterState {
  final String error;
  FilterError(this.error);
}

class FilterEmpty extends FilterState {}
