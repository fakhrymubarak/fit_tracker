import 'package:dartz/dartz.dart';
import 'package:fit_tracker/profile/domain/entities/user_profile.dart';

import '../../../core/core.dart';
import '../repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase({required this.repository});

  Future<Either<Failure, UserProfile>> execute() {
    return repository.getUserProfile();
  }
}
