part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileCompleteState extends ProfileState {
  final bool state;

  ProfileCompleteState(this.state);
}

// Fetch Profile
class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String message;

  ProfileErrorState(this.message);
}

class ProfileHasDataState extends ProfileState {
  final UserProfile profile;

  ProfileHasDataState(this.profile);
}

// Profile Update
class ProfileUpdateSucceedState extends ProfileState {}
