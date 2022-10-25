import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fit_tracker/home/domain/usecases/insert_weights_usecase.dart';
import 'package:fit_tracker/home/domain/usecases/update_weights_usecase.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'weight_event.dart';
part 'weight_state.dart';

class WeightBloc extends Bloc<WeightEvent, WeightState> {
  static const weightIsEmpty = 'Weight field is required.';
  static const dateIsEmpty = 'Date field is required.';

  final InsertWeightUseCase insertUseCase;
  final UpdateWeightUseCase updateUseCase;
  String _date = '';
  int _weight = 0;

  WeightBloc(this.insertUseCase, this.updateUseCase) : super(WeightInitial()) {
    on<InsertNewWeightEvent>(
      _insertNewHeight,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<UpdateWeightEvent>(
      _updateWeightEvent,
      transformer: (events, mapper) => events.switchMap(mapper),
    );

    on<EditWeightDate>(
      _insertWeightDate,
      transformer: (events, mapper) => events.switchMap(mapper),
    );

    on<EditWeight>(
      _insertWeight,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  FutureOr<void> _insertNewHeight(
    InsertNewWeightEvent event,
    Emitter<WeightState> emit,
  ) async {
    emit(WeightLoadingState());
    if (_date.isEmpty) {
      emit(WeightErrorState(dateIsEmpty));
      return;
    }

    if (_weight <= 0) {
      emit(WeightErrorState(weightIsEmpty));
      return;
    }

    final result = await insertUseCase.execute(_date, _weight);

    result.fold(
      (failure) => emit(WeightErrorState(failure.message)),
      (data) => emit(WeightSucceedState()),
    );
  }

  FutureOr<void> _updateWeightEvent(
    UpdateWeightEvent event,
    Emitter<WeightState> emit,
  ) async {
    emit(WeightLoadingState());
    if (_date.isEmpty) {
      emit(WeightErrorState(dateIsEmpty));
      return;
    }

    if (_weight <= 0) {
      emit(WeightErrorState(weightIsEmpty));
      return;
    }

    final result = await updateUseCase.execute(event.idData, _date, _weight);

    result.fold(
      (failure) => emit(WeightErrorState(failure.message)),
      (data) => emit(WeightSucceedState()),
    );
  }

  FutureOr<void> _insertWeightDate(
    EditWeightDate event,
    Emitter<WeightState> emit,
  ) {
    _date = event.date;
  }

  FutureOr<void> _insertWeight(
    EditWeight event,
    Emitter<WeightState> emit,
  ) {
    _weight = event.weight;
  }
}
