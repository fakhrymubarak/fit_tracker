import 'package:dartz/dartz.dart';
import 'package:fit_tracker/profile/domain/entities/user_profile.dart';

import '../../../core/core.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase({required this.repository});

  Future<Either<Failure, bool>> execute({
    required String name,
    required Gender gender,
    required String birthDate,
    required int height,
  }) {
    return repository.updateUserProfile(name, gender, birthDate, height);
  }
}
