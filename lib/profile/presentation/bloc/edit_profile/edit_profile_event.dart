part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileEvent {}

class EditProfileName extends EditProfileEvent {
  final String name;

  EditProfileName(this.name);
}

class UpdateProfileEvent extends EditProfileEvent {
  UpdateProfileEvent();
}

/* FILLED FORM EVENT */
class EditProfileHeight extends EditProfileEvent {
  final int height;

  EditProfileHeight(this.height);
}

class EditProfileGender extends EditProfileEvent {
  final Gender? gender;

  EditProfileGender(this.gender);
}

class EditProfileBirthDate extends EditProfileEvent {
  final String birthDate;

  EditProfileBirthDate(this.birthDate);
}
