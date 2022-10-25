import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../../profile/profile.dart';
import '../../../register/register.dart';

abstract class LoginRepository {
  Future<Either<Failure, UserProfile>> loginUser(AuthenticationForm form);
  Future<bool> hasLogin();
}
