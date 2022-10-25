import 'package:dartz/dartz.dart';
import 'package:fit_tracker/home/data/models/weight.dart';

import '../../../core/core.dart';
import '../repositories/weight_repository.dart';

class UpdateWeightUseCase {
  final WeightRepository repository;

  UpdateWeightUseCase({required this.repository});

  Future<Either<Failure, bool>> execute(
      String id, String date, int weight) async {
    final data = Weight(id: id, inputDate: date, weight: weight);
    return repository.updateUserWeight(data);
  }
}
