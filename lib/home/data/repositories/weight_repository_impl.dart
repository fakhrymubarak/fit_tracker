import 'package:dartz/dartz.dart';
import 'package:fit_tracker/home/data/data_sources/weight_remote_data_sources.dart';
import 'package:flutter/cupertino.dart';

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

  @override
  Future<Either<Failure, bool>> insertUserWeight(
      String date, int weight) async {
    if (await networkInfo.isConnected) {
      try {
        final uid = await preference.getString(PrefKey.userUid);

        final data = Weight(id: '', inputDate: date, weight: weight);
        await remoteDataSource.insertUserWeight(uid!, data);
        return const Right(true);
      } on AuthException catch (e) {
        return Left(AuthFailure(e.message));
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      } catch (e) {
        debugPrint(e.toString());
        return const Left(UnknownFailure.fail);
      }
    } else {
      return const Left(ConnectionFailure.networkFailure);
    }
  }

  @override
  Future<Either<Failure, bool>> updateUserWeight(Weight data) async {
    if (await networkInfo.isConnected) {
      try {
        final uid = await preference.getString(PrefKey.userUid);

        await remoteDataSource.updateUserWeight(uid!, data);
        return const Right(true);
      } on AuthException catch (e) {
        return Left(AuthFailure(e.message));
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      } catch (e) {
        debugPrint(e.toString());
        return const Left(UnknownFailure.fail);
      }
    } else {
      return const Left(ConnectionFailure.networkFailure);
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUserWeight(Weight data) async {
    if (await networkInfo.isConnected) {
      try {
        final uid = await preference.getString(PrefKey.userUid);

        await remoteDataSource.deleteUserWeight(uid!, data);
        return const Right(true);
      } on AuthException catch (e) {
        return Left(AuthFailure(e.message));
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      } catch (e) {
        debugPrint(e.toString());
        return const Left(UnknownFailure.fail);
      }
    } else {
      return const Left(ConnectionFailure.networkFailure);
    }
  }
}
