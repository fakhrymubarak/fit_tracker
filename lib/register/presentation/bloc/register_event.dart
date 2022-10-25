part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

// Register User Event
class RegisterUserEvent extends RegisterEvent {}

// Email Validation Event
class EmailValidateEvent extends RegisterEvent {
  final String email;

  EmailValidateEvent(this.email);
}

// Pass Validation Event
class PassValidateEvent extends RegisterEvent {
  final String password;

  PassValidateEvent(this.password);
}

// Confirm Pass Validation Event
class ConfirmPassValidateEvent extends RegisterEvent {
  final String confirmPassword;

  ConfirmPassValidateEvent(this.confirmPassword);
}
