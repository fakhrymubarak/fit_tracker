import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../data/models/weight.dart';

abstract class WeightRepository {
  Future<Either<Failure, List<Weight>>> getUserWeights();
}