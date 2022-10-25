part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

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
