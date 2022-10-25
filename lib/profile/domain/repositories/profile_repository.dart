import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../entities/user_profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfile>> getUserProfile();

  Future<Either<Failure, bool>> updateUserProfile(
    String name,
    String gender,
    String birthDate,
    int height,
  );

  Future<void> logoutUser();
}
