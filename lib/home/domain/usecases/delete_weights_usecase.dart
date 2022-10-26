import 'package:dartz/dartz.dart';
import 'package:fit_tracker/home/data/models/weight.dart';

import '../../../core/core.dart';
import '../repositories/weight_repository.dart';

class DeleteWeightUseCase {
  final WeightRepository repository;

  DeleteWeightUseCase({required this.repository});

  Future<Either<Failure, bool>> execute(Weight weight) async {
    return repository.deleteUserWeight(weight);
  }
}
