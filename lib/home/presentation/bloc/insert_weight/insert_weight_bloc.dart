import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fit_tracker/home/domain/usecases/insert_weights_usecase.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'insert_weight_event.dart';
part 'insert_weight_state.dart';

class InsertWeightBloc extends Bloc<InsertWeightEvent, InsertWeightState> {
  static const weightIsEmpty = 'Weight field is required.';
  static const dateIsEmpty = 'Date field is required.';

  final InsertWeightUseCase useCase;
  String _date = '';
  int _weight = 0;

  InsertWeightBloc(this.useCase) : super(InsertWeightInitial()) {
    on<InsertNewWeightEvent>(
      _insertNewHeight,
      transformer: (events, mapper) => events.switchMap(mapper),
    );

    on<InsertWeightDate>(
      _insertWeightDate,
      transformer: (events, mapper) => events.switchMap(mapper),
    );

    on<InsertWeight>(
      _insertWeight,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  FutureOr<void> _insertNewHeight(
    InsertNewWeightEvent event,
    Emitter<InsertWeightState> emit,
  ) async {
    emit(InsertWeightLoadingState());
    if (_date.isEmpty) {
      emit(InsertWeightErrorState(dateIsEmpty));
      return;
    }

    if (_weight <= 0) {
      emit(InsertWeightErrorState(weightIsEmpty));
      return;
    }

    final result = await useCase.execute(_date, _weight);

    result.fold(
      (failure) => emit(InsertWeightErrorState(failure.message)),
      (data) => emit(InsertWeightSucceedState()),
    );
  }

  FutureOr<void> _insertWeightDate(
    InsertWeightDate event,
    Emitter<InsertWeightState> emit,
  ) {
    _date = event.date;
  }

  FutureOr<void> _insertWeight(
    InsertWeight event,
    Emitter<InsertWeightState> emit,
  ) {
    _weight = event.weight;
  }
}
