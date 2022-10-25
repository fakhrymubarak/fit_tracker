part of 'insert_weight_bloc.dart';

@immutable
abstract class InsertWeightState {}

class InsertWeightInitial extends InsertWeightState {}

// EditProfile User State
class InsertWeightLoadingState extends InsertWeightState {}

class InsertWeightErrorState extends InsertWeightState {
  final String message;

  InsertWeightErrorState(this.message);
}

class InsertWeightSucceedState extends InsertWeightState {}
