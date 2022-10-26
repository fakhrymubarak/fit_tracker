import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../data/models/weight.dart';
import '../repositories/weight_repository.dart';

class GetUserWeightsUseCase {
  final WeightRepository repository;

  GetUserWeightsUseCase({required this.repository});

  Future<Either<Failure, Stream<List<Weight>>>> execute() async {
    final result = repository.getUserWeights();
    return result.then(
      (value) => value.flatMap(
        (stream) {
          final mappedStream = stream.map((listWeight) {
            listWeight.sort((a, b) => b.inputDate.compareTo(a.inputDate));
            final List<Weight> result = List.from(listWeight);
            return result;
          });
          return Right(mappedStream);
        },
      ),
    );
  }
}
