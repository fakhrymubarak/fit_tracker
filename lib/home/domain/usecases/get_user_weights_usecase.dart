import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../data/models/weight.dart';
import '../repositories/weight_repository.dart';

class GetUserWeightsUseCase {
  final WeightRepository repository;

  GetUserWeightsUseCase({required this.repository});

  Future<Either<Failure, List<Weight>>> execute() async {
    final result = repository.getUserWeights();
    return result.then(
      (value) => value.flatMap(
        (listWeight) {
          listWeight.sort((a, b) => b.inputDate.compareTo(a.inputDate));
          final List<Weight> result = List.from(listWeight);
          return Right(result);
        },
      ),
    );
  }
}
