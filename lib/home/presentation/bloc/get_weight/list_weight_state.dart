part of 'list_weight_cubit.dart';

@immutable
abstract class ListWeightState {}

class ListWeightInitial extends ListWeightState {}

class ListWeightLoadingState extends ListWeightState {}

class ListWeightHasDataState extends ListWeightState {
  final List<Weight> weights;

  ListWeightHasDataState(this.weights);
}

class ListWeightErrorState extends ListWeightState {
  final String message;

  ListWeightErrorState(this.message);
}
