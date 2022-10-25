import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'insert_weight_state.dart';

class InsertWeightCubit extends Cubit<InsertWeightState> {
  InsertWeightCubit() : super(InsertWeightInitial());


}
