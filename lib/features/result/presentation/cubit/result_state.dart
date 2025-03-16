import 'package:kgkdiamonds/core/models/data.dart';

abstract class ResultCubitState {}

class ResultCubitInitial extends ResultCubitState {
  final List<DataModel> diamondsList;

  ResultCubitInitial() : diamondsList = [];
}

class ResultCubitLoading extends ResultCubitState {}

class ResultCubitLoaded extends ResultCubitState {
  final List<DataModel> filteredList;
  final Set<int> selectedDiamonds;
  ResultCubitLoaded(this.filteredList, this.selectedDiamonds);
}

class ResultCubitEmpty extends ResultCubitState {
  final String message;
  ResultCubitEmpty({this.message = "No data found."});
}

class ResultCubitError extends ResultCubitState {
  final String error;
  ResultCubitError(this.error);
}
