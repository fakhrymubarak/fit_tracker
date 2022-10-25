import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum Gender { male, female }

class UserProfile extends Equatable {
  static const collectionName = 'users';

  final String uid;
  final String email;
  final String? name;
  final Gender? gender;
  final String? birthDate;
  final int? height;
  final String? profileUrl;
  final bool isProfileComplete;

  const UserProfile({
    required this.uid,
    required this.email,
    this.name,
    this.gender,
    this.birthDate,
    this.height,
    this.profileUrl,
    this.isProfileComplete = false,
  });

  factory UserProfile.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data();
    return UserProfile(
      uid: data?['uid'],
      email: data?['email'],
      name: data?['name'],
      gender: data?['gender'],
      birthDate: data?['birth_date'],
      height: data?['height'],
      profileUrl: data?['profile_url'],
      isProfileComplete: data?['is_profile_completed'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "email": email,
      if (name != null) "name": name,
      if (gender != null) "gender": gender,
      if (birthDate != null) "birth_date": birthDate,
      if (height != null) "height": height,
      if (profileUrl != null) "profile_url": profileUrl,
      "is_profile_completed": isProfileComplete,
    };
  }

  @override
  List<Object?> get props => [email, isProfileComplete];
}
