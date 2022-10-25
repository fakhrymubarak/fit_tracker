part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileEvent {}

// Register User Event
class RegisterUserEvent extends EditProfileEvent {}

// Email Validation Event
class EmailValidateEvent extends EditProfileEvent {
  final String email;

  EmailValidateEvent(this.email);
}

// Pass Validation Event
class PassValidateEvent extends EditProfileEvent {
  final String password;

  PassValidateEvent(this.password);
}

// Confirm Pass Validation Event
class ConfirmPassValidateEvent extends EditProfileEvent {
  final String confirmPassword;

  ConfirmPassValidateEvent(this.confirmPassword);
}
