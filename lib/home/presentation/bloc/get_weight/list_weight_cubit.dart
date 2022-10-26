import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fit_tracker/home/data/models/weight.dart';
import 'package:fit_tracker/home/domain/usecases/get_user_weights_usecase.dart';
import 'package:meta/meta.dart';

part 'list_weight_state.dart';

class ListWeightCubit extends Cubit<ListWeightState> {
  final GetUserWeightsUseCase useCase;
  var fakeStream = Stream<int>.periodic(const Duration(seconds: 1), (x) => x).take(180);

  ListWeightCubit(this.useCase) : super(ListWeightInitial()) {
    fakeStream.listen((_) {
      fetchUserWeights();
    });
  }

  FutureOr<void> fetchUserWeights() async {
    final result = await useCase.execute();

    result.fold(
      (failure) => emit(ListWeightErrorState(failure.message)),
      (data) => emit(
        ListWeightHasDataState(data),
      ),
    );
  }
}
