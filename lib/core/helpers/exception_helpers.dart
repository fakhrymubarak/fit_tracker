class ServerException implements Exception {}

class AuthException implements Exception {
  static const String unknownError = 'Authentication failed for unknown reason. Please contact us.';
  final String message;

  AuthException(this.message);
}

class DatabaseException implements Exception {
  static const String unknownError = 'Database failed for unknown reason. Please contact us.';
  final String message;

  DatabaseException(this.message);
}
