part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileFetchEvent extends ProfileEvent {}

class ProfileUpdateEvent extends ProfileEvent {
  final String name;
  final String gender;
  final DateTime birthDate;
  final int height;

  ProfileUpdateEvent(this.name, this.gender, this.birthDate, this.height);
}
