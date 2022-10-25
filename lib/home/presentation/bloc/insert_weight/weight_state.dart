part of 'weight_bloc.dart';

@immutable
abstract class WeightState {}

class WeightInitial extends WeightState {}

// EditProfile User State
class WeightLoadingState extends WeightState {}

class WeightErrorState extends WeightState {
  final String message;

  WeightErrorState(this.message);
}

class WeightSucceedState extends WeightState {}
