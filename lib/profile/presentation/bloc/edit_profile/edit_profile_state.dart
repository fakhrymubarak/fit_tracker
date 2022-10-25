part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

// EditProfile User State
class EditProfileLoadingState extends EditProfileState {}

class EditProfileErrorState extends EditProfileState {
  final String message;

  EditProfileErrorState(this.message);
}

class EditProfileSucceedState extends EditProfileState {}
