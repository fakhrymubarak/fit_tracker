import '../repositories/login_repository.dart';

class CheckHasLoginUseCase {
  final LoginRepository repository;

  CheckHasLoginUseCase({required this.repository});

  Future<bool> execute() {
    return repository.hasLogin();
  }
}
