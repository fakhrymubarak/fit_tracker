import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fit_tracker/profile/domain/entities/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecases/update_profile_usecase.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  static const nameIsEmpty = 'Name field is required.';
  static const heightIsEmpty = 'Height field is required.';
  static const genderIsEmpty = 'Gender field is required.';
  static const birthDateIsEmpty = 'Birth date field is required.';

  final UpdateProfileUseCase useCase;
  String _name = '';
  int _height = 0;
  Gender? _gender;
  String _birthDate = '';

  EditProfileBloc(this.useCase) : super(EditProfileInitial()) {
    on<UpdateProfileEvent>(
      _updateProfileEvent,
      transformer: (events, mapper) => events.switchMap(mapper),
    );

    on<EditProfileName>(
      _editProfileNameEvent,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<EditProfileHeight>(
      _editProfileHeightEvent,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<EditProfileGender>(
      _editProfileGenderEvent,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<EditProfileBirthDate>(
      _editProfileBirthDateEvent,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  FutureOr<void> _updateProfileEvent(
    UpdateProfileEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    if (_name.isEmpty) {
      emit(EditProfileErrorState(nameIsEmpty));
      return;
    }
    if (_height <= 0) {
      emit(EditProfileErrorState(heightIsEmpty));
      return;
    }
    if (_gender == null) {
      emit(EditProfileErrorState(genderIsEmpty));
      return;
    }
    if (_birthDate.isEmpty) {
      emit(EditProfileErrorState(birthDateIsEmpty));
      return;
    }

    final result = await useCase.execute(
      name: _name,
      gender: _gender!,
      birthDate: _birthDate,
      height: _height,
    );

    result.fold(
      (failure) => emit(EditProfileErrorState(failure.message)),
      (data) => emit(EditProfileSucceedState()),
    );
  }

  FutureOr<void> _editProfileNameEvent(
    EditProfileName event,
    Emitter<EditProfileState> emit,
  ) {
    _name = event.name;
  }

  FutureOr<void> _editProfileHeightEvent(
    EditProfileHeight event,
    Emitter<EditProfileState> emit,
  ) {
    _height = event.height;
  }

  FutureOr<void> _editProfileGenderEvent(
    EditProfileGender event,
    Emitter<EditProfileState> emit,
  ) {
    _gender = event.gender;
  }

  FutureOr<void> _editProfileBirthDateEvent(
    EditProfileBirthDate event,
    Emitter<EditProfileState> emit,
  ) {
    _birthDate = event.birthDate;
  }
}
