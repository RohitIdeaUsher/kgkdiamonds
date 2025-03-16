import '../../models/data.dart';

abstract class DiamondCubitState {}

class DiamondInitial extends DiamondCubitState {
  final List<DataModel> diamondsList;

  DiamondInitial() : diamondsList = [];
}

class DiamondLoading extends DiamondCubitState {}

class DiamondLoaded extends DiamondCubitState {
  final List<DataModel> diamondsList;
  DiamondLoaded(this.diamondsList);
}

class DiamondError extends DiamondCubitState {
  final String error;
  DiamondError(this.error);
}
