part of 'weight_bloc.dart';

@immutable
abstract class WeightEvent {}

/* INSERT NEW WEIGHT */
class InsertNewWeightEvent extends WeightEvent {}

/* UPDATE NEW WEIGHT */
class UpdateWeightEvent extends WeightEvent {
  final String idData;

  UpdateWeightEvent(this.idData);
}

/* FILLED FORM EVENT */
class EditWeightDate extends WeightEvent {
  final String date;

  EditWeightDate(this.date);
}

class EditWeight extends WeightEvent {
  final int weight;

  EditWeight(this.weight);
}
