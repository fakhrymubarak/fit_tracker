part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

// Check Has Login
class HasLoginCheckedEvent extends LoginEvent {}

// Login User Event
class LoginUserEvent extends LoginEvent {}

// Email Validation Event
class EmailValidateEvent extends LoginEvent {
  final String email;

  EmailValidateEvent(this.email);
}

// Pass Validation Event
class PassValidateEvent extends LoginEvent {
  final String password;

  PassValidateEvent(this.password);
}