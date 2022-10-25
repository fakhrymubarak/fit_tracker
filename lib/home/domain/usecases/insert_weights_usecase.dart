import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../repositories/weight_repository.dart';

class InsertWeightUseCase {
  final WeightRepository repository;

  InsertWeightUseCase({required this.repository});

  Future<Either<Failure, bool>> execute(String date, int weight) async {
    return repository.insertUserWeight(date, weight);
  }
}
