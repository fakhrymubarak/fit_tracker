import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../../profile/profile.dart';
import '../../../register/register.dart';
import '../../domain/repositories/login_repository.dart';
import '../data_sources/login_remote_data_sources.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final Preferences preference;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    required this.remoteDataSource,
    required this.preference,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserProfile>> loginUser(
      AuthenticationForm form) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.loginUser(form);
        preference.setString(PrefKey.userUid, result.uid);
        preference.setString(PrefKey.email, result.email);

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
  Future<bool> hasLogin() async {
    final result = await preference.getString(PrefKey.userUid);
    return result != null && result != '';
  }
}
