import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../profile/profile.dart';
import '../../../register/register.dart';

abstract class LoginRemoteDataSource {
  Future<UserProfile> loginUser(AuthenticationForm form);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  @override
  Future<UserProfile> loginUser(AuthenticationForm form) async {
    final auth = FirebaseAuth.instance;
    try {
      final UserCredential user = await auth.signInWithEmailAndPassword(
        email: form.email,
        password: form.password,
      );
      return UserProfile(
          email: user.user?.email ?? '', uid: user.user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? AuthException.unknownError);
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }
}
