part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

// EditProfile User State
class EditProfileButtonState extends EditProfileState {
  final bool isEnabled;

  EditProfileButtonState({required this.isEnabled});
}

class EditProfileUserLoadingState extends EditProfileState {}

class EditProfileUserErrorState extends EditProfileState {
  final String message;

  EditProfileUserErrorState(this.message);
}

class EditProfileUserSucceedState extends EditProfileState {
  EditProfileUserSucceedState();
}

// Email Validation State
class EmailValidState extends EditProfileState {}

class EmailNotValidState extends EditProfileState {
  final String errorMessage;

  EmailNotValidState(this.errorMessage);
}

// Pass Validation State
class PassValidState extends EditProfileState {}

class PassNotValidState extends EditProfileState {
  final String errorMessage;

  PassNotValidState(this.errorMessage);
}

// Confirm Pass Validation State
class ConfirmPassValidState extends EditProfileState {}

class ConfirmPassNotValidState extends EditProfileState {
  final String errorMessage;

  ConfirmPassNotValidState(this.errorMessage);
}
