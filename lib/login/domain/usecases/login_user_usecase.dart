import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../../profile/profile.dart';
import '../../../register/register.dart';
import '../repositories/login_repository.dart';

class LoginUserUseCase {
  final LoginRepository repository;

  LoginUserUseCase({required this.repository});

  Future<Either<Failure, UserProfile>> execute(AuthenticationForm form) {
    return repository.loginUser(form);
  }
}
