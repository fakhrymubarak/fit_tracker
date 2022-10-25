part of 'insert_weight_bloc.dart';

@immutable
abstract class InsertWeightEvent {}

class InsertNewWeightEvent extends InsertWeightEvent {
  InsertNewWeightEvent();
}

/* FILLED FORM EVENT */
class InsertWeightDate extends InsertWeightEvent {
  final String date;

  InsertWeightDate(this.date);
}

class InsertWeight extends InsertWeightEvent {
  final int weight;

  InsertWeight(this.weight);
}
