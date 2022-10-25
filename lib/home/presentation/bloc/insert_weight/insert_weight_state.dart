part of 'insert_weight_cubit.dart';

@immutable
abstract class InsertWeightState {}
class InsertWeightInitial extends InsertWeightState {}

class InsertWeightSucceedState extends InsertWeightState {}
class InsertWeightLoadingState extends InsertWeightState {}
class InsertWeightErrorState extends InsertWeightState {}
