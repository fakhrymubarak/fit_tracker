part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

// Register User State
class RegisterButtonState extends RegisterState {
  final bool isEnabled;

  RegisterButtonState({required this.isEnabled});
}

class RegisterUserLoadingState extends RegisterState {}

class RegisterUserErrorState extends RegisterState {
  final String message;

  RegisterUserErrorState(this.message);
}

class RegisterUserSucceedState extends RegisterState {
  RegisterUserSucceedState();
}

// Email Validation State
class EmailValidState extends RegisterState {}

class EmailNotValidState extends RegisterState {
  final String errorMessage;

  EmailNotValidState(this.errorMessage);
}

// Pass Validation State
class PassValidState extends RegisterState {}

class PassNotValidState extends RegisterState {
  final String errorMessage;

  PassNotValidState(this.errorMessage);
}

// Confirm Pass Validation State
class ConfirmPassValidState extends RegisterState {}

class ConfirmPassNotValidState extends RegisterState {
  final String errorMessage;

  ConfirmPassNotValidState(this.errorMessage);
}
