import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase({required this.repository});

  Future<Either<Failure, bool>> execute(
    String name,
    String gender,
    String birthDate,
    int height,
  ) {
    return repository.updateUserProfile(name, gender, birthDate, height);
  }
}
