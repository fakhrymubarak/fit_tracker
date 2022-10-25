import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fit_tracker/profile/domain/usecases/update_profile_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';


part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  static const emptyField = 'This field is required.';
  static const msgPasswordNotMatch = 'Password does not match';
  static const msgPasswordTooShort = 'Password must be at least 6 characters.';
  static const msgEmailNotValid = 'Email format not valid.';

  final UpdateProfileUseCase useCase;
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  bool _isEmailValid = false;
  bool _isPassValid = false;
  bool _isConfPassValid = false;

  EditProfileBloc(this.useCase) : super(EditProfileInitial()) {
  }

  bool _isSignUpEnabled() => _isEmailValid && _isPassValid && _isConfPassValid;
}
