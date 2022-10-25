import 'package:dartz/dartz.dart';
import 'package:fit_tracker/core/helpers/failure_helpers.dart';
import 'package:fit_tracker/core/helpers/network_info_helpers.dart';
import 'package:fit_tracker/register/data/data_sources/register_remote_data_source.dart';
import 'package:fit_tracker/register/domain/entities/authentication_form.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/core.dart';
import '../../domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RegisterRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> registerUser(
      AuthenticationForm registerForm) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.registerUserAuth(registerForm);
        return const Right(true);
      }  on AuthException catch (e) {
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
