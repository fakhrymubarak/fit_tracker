import '../repositories/profile_repository.dart';

class LogoutUseCase {
  final ProfileRepository repository;

  LogoutUseCase({required this.repository});

  Future<void> execute() {
    return repository.logoutUser();
  }
}
