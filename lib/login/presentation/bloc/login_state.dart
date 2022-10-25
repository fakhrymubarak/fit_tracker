part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

// Login User Button State
class HasLoginState extends LoginState {
  final bool hasLogin;

  HasLoginState({required this.hasLogin});
}
// Login User Button State
class LoginButtonState extends LoginState {
  final bool isEnabled;

  LoginButtonState({required this.isEnabled});
}

class LoginUserLoadingState extends LoginState {}

class LoginUserErrorState extends LoginState {
  final String message;

  LoginUserErrorState(this.message);
}

class LoginUserSucceedState extends LoginState {
  LoginUserSucceedState();
}

// Email Validation State
class EmailValidState extends LoginState {}

class EmailNotValidState extends LoginState {
  final String errorMessage;

  EmailNotValidState(this.errorMessage);
}

// Pass Validation State
class PassValidState extends LoginState {}

class PassNotValidState extends LoginState {
  final String errorMessage;

  PassNotValidState(this.errorMessage);
}