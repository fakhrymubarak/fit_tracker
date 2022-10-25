import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class AuthFailure extends Failure {
  const AuthFailure(String message) : super(message);
}

class ConnectionFailure extends Failure {
  static const networkFailure = ConnectionFailure('Failed to connect with the network. Please check your internet connection.');

  const ConnectionFailure(String message) : super(message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}


class UnknownFailure extends Failure {
  static const fail = UnknownFailure('Unknown failure. Please try again or contact us.');
  const UnknownFailure(String message) : super(message);
}
