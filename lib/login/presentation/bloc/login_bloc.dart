import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fit_tracker/login/domain/usecases/check_has_login_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/transformers.dart';

import '../../../register/domain/entities/authentication_form.dart';
import '../../domain/usecases/login_user_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  static const emptyField = 'This field is required.';
  static const msgPasswordTooShort = 'Password must be at least 6 characters.';
  static const msgEmailNotValid = 'Email format not valid.';

  final LoginUserUseCase loginUserUseCase;
  final CheckHasLoginUseCase checkHasLoginUseCase;
  String _email = '';
  String _password = '';

  bool _isEmailValid = false;
  bool _isPassValid = false;

  LoginBloc(this.loginUserUseCase, this.checkHasLoginUseCase)
      : super(LoginInitial()) {
    on<HasLoginCheckedEvent>(
      _checkHasLogin,
      transformer: (events, mapper) => events.switchMap(mapper),
    );

    on<LoginUserEvent>(
      _loginUserEvent,
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
  }

  FutureOr<void> _loginUserEvent(
    LoginUserEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginUserLoadingState());

    final registerForm = AuthenticationForm(
      email: _email,
      password: _password,
    );

    final result = await loginUserUseCase.execute(registerForm);

    result.fold(
      (failure) => {
        emit(LoginUserErrorState(failure.message)),
        emit(LoginButtonState(isEnabled: _isSignInEnabled()))
      },
      (data) => emit(LoginUserSucceedState()),
    );
  }

  FutureOr<void> _validateEmail(
    EmailValidateEvent event,
    Emitter<LoginState> emit,
  ) async {
    final emailPattern = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    _email = event.email.trim();

    if (_email.isEmpty) {
      _isEmailValid = false;
      emit(LoginButtonState(isEnabled: _isSignInEnabled()));
      emit(EmailNotValidState(emptyField));
      return;
    }

    if (!emailPattern.hasMatch(_email)) {
      _isEmailValid = false;
      emit(LoginButtonState(isEnabled: _isSignInEnabled()));
      emit(EmailNotValidState(msgEmailNotValid));
      return;
    }

    _isEmailValid = true;
    emit(EmailValidState());
    emit(LoginButtonState(isEnabled: _isSignInEnabled()));
  }

  FutureOr<void> _validatePassword(
    PassValidateEvent event,
    Emitter<LoginState> emit,
  ) async {
    _password = event.password.trim();

    if (_password.isEmpty) {
      _isPassValid = false;
      emit(LoginButtonState(isEnabled: _isSignInEnabled()));
      emit(PassNotValidState(emptyField));
      return;
    }

    if (_password.length < 6) {
      _isPassValid = false;
      emit(LoginButtonState(isEnabled: _isSignInEnabled()));
      emit(PassNotValidState(msgPasswordTooShort));
      return;
    }

    _isPassValid = true;
    emit(PassValidState());
    emit(LoginButtonState(isEnabled: _isSignInEnabled()));
  }

  bool _isSignInEnabled() => _isEmailValid && _isPassValid;

  FutureOr<void> _checkHasLogin(
    HasLoginCheckedEvent event,
    Emitter<LoginState> emit,
  ) async {
    final result = await checkHasLoginUseCase.execute();
    emit(HasLoginState(hasLogin: result));
  }
}
