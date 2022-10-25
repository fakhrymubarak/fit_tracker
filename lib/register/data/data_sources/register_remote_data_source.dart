import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/core.dart';
import '../../../profile/profile.dart';
import '../../domain/entities/authentication_form.dart';

abstract class RegisterRemoteDataSource {
  Future<UserProfile> registerUserAuth(AuthenticationForm registerForm);
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  @override
  Future<UserProfile> registerUserAuth(AuthenticationForm registerForm) async {
    final auth = FirebaseAuth.instance;

    try {
      final UserCredential userCred = await auth.createUserWithEmailAndPassword(
        email: registerForm.email,
        password: registerForm.password,
      );

      final userProfile = UserProfile(uid: userCred.user!.uid, email: registerForm.email);
      _registerUserDb(userProfile);

      return userProfile;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? AuthException.unknownError);
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  Future<void> _registerUserDb(UserProfile user) async {
    final db = FirebaseFirestore.instance;
    try {
      db
          .collection(UserProfile.collectionName)
          .doc(user.uid)
          .set(user.toFirestore());
    } catch (e) {
      debugPrint(e.toString());
      throw DatabaseException(e.toString());
    }
  }
}
