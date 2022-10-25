import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../entities/authentication_form.dart';
import '../repositories/register_repository.dart';

class RegisterUserUseCase {
  final RegisterRepository repository;

  RegisterUserUseCase({required this.repository});

  Future<Either<Failure, bool>> execute(
      AuthenticationForm registerForm) {
    return repository.registerUser(registerForm);
  }
}
