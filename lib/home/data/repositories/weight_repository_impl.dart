import 'package:dartz/dartz.dart';
import 'package:fit_tracker/home/data/data_sources/weight_remote_data_sources.dart';

import '../../../core/core.dart';
import '../../data/models/weight.dart';
import '../../domain/repositories/weight_repository.dart';

class WeightRepositoryImpl extends WeightRepository {
  final WeightRemoteDataSource remoteDataSource;
  final Preferences preference;
  final NetworkInfo networkInfo;

  WeightRepositoryImpl({
    required this.remoteDataSource,
    required this.preference,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Weight>>> getUserWeights() async {
    if (await networkInfo.isConnected) {
      try {
        final uid = await preference.getString(PrefKey.userUid);

        final result = await remoteDataSource.getListHeight(uid!);
        return Right(result);
      } on AuthException catch (e) {
        return Left(AuthFailure(e.message));
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      }
    } else {
      return const Left(ConnectionFailure.networkFailure);
    }
  }
}
