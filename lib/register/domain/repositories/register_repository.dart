import 'package:dartz/dartz.dart';
import 'package:fit_tracker/register/domain/entities/authentication_form.dart';

import '../../../core/core.dart';

abstract class RegisterRepository {
  Future<Either<Failure, bool>> registerUser(
      AuthenticationForm registerForm);
}
