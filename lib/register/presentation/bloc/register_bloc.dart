import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/transformers.dart';

import '../../domain/entities/authentication_form.dart';
import '../../domain/usecases/register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  static const emptyField = 'This field is required.';
  static const msgPasswordNotMatch = 'Password does not match';
  static const msgPasswordTooShort = 'Password must be at least 6 characters.';
  static const msgEmailNotValid = 'Email format not valid.';

  final RegisterUserUseCase useCase;
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  bool _isEmailValid = false;
  bool _isPassValid = false;
  bool _isConfPassValid = false;

  RegisterBloc(this.useCase) : super(RegisterInitial()) {
    on<RegisterUserEvent>(
      _registerUserEvent,
      transformer: (events, mapper) => events.switchMap(mapper),
    );

    on<EmailValidateEvent>(
      _validateEmail,
      transformer: (events, mapper) => events.switchMap(mapper),
    );

    on<PassValidateEvent>(
      _validatePassword,
      transformer: (events, mapper) => events.switchMap(mapper),
    );

    on<ConfirmPassValidateEvent>(
      _validateConfirmPassword,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  FutureOr<void> _registerUserEvent(
    RegisterUserEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterUserLoadingState());

    final registerForm = AuthenticationForm(
      email: _email,
      password: _password,
    );

    final result = await useCase.execute(registerForm);

    result.fold(
      (failure) => {
        emit(RegisterUserErrorState(failure.message)),
        emit(RegisterButtonState(isEnabled: true))
      },
      (data) => emit(RegisterUserSucceedState()),
    );
  }

  FutureOr<void> _validateEmail(
    EmailValidateEvent event,
    Emitter<RegisterState> emit,
  ) async {
    final emailPattern = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    _email = event.email.trim();

    if (_email.isEmpty) {
      _isEmailValid = false;
      emit(RegisterButtonState(isEnabled: _isSignUpEnabled()));
      emit(EmailNotValidState(emptyField));
      return;
    }

    if (!emailPattern.hasMatch(_email)) {
      _isEmailValid = false;
      emit(RegisterButtonState(isEnabled: _isSignUpEnabled()));
      emit(EmailNotValidState(msgEmailNotValid));
      return;
    }

    _isEmailValid = true;
    emit(EmailValidState());
    emit(RegisterButtonState(isEnabled: _isSignUpEnabled()));
  }

  FutureOr<void> _validatePassword(
    PassValidateEvent event,
    Emitter<RegisterState> emit,
  ) async {
    _password = event.password.trim();

    if (_password.isEmpty) {
      _isPassValid = false;
      emit(RegisterButtonState(isEnabled: _isSignUpEnabled()));
      emit(PassNotValidState(emptyField));
      return;
    }

    if (_password.length < 6) {
      _isPassValid = false;
      emit(RegisterButtonState(isEnabled: _isSignUpEnabled()));
      emit(PassNotValidState(msgPasswordTooShort));
      return;
    }

    if (_password == _confirmPassword) {
      emit(ConfirmPassValidState());
      _isConfPassValid = true;
    }

    _isPassValid = true;
    emit(PassValidState());
    emit(RegisterButtonState(isEnabled: _isSignUpEnabled()));
  }

  FutureOr<void> _validateConfirmPassword(
    ConfirmPassValidateEvent event,
    Emitter<RegisterState> emit,
  ) async {
    _confirmPassword = event.confirmPassword.trim();

    if (_confirmPassword.isEmpty) {
      _isConfPassValid = false;
      emit(RegisterButtonState(isEnabled: _isSignUpEnabled()));
      emit(ConfirmPassNotValidState(emptyField));
      return;
    }

    if (_confirmPassword.length < 6) {
      _isConfPassValid = false;
      emit(RegisterButtonState(isEnabled: _isSignUpEnabled()));
      emit(ConfirmPassNotValidState(msgPasswordTooShort));
      return;
    }

    if (_password != _confirmPassword) {
      _isConfPassValid = false;
      emit(RegisterButtonState(isEnabled: _isSignUpEnabled()));
      emit(ConfirmPassNotValidState(msgPasswordNotMatch));
      return;
    }

    _isConfPassValid = true;
    emit(ConfirmPassValidState());
    emit(RegisterButtonState(isEnabled: _isSignUpEnabled()));
  }

  bool _isSignUpEnabled() => _isEmailValid && _isPassValid && _isConfPassValid;
}
