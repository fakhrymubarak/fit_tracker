import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../data/models/weight.dart';

abstract class WeightRepository {
  Future<Either<Failure, List<Weight>>> getUserWeights();

  Future<Either<Failure, bool>> insertUserWeight(String date, int weight);

  Future<Either<Failure, bool>> updateUserWeight(Weight data);

  Future<Either<Failure, bool>> deleteUserWeight(Weight data);
}
