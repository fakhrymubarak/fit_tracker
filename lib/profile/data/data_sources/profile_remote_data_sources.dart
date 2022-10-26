import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../profile/profile.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfile> getUserProfile(String uid);

  Future<bool> updateUserProfile(UserProfile profile);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final db = FirebaseFirestore.instance;

  @override
  Future<UserProfile> getUserProfile(String uid) async {
    try {
      final docRefs = db.collection(UserProfile.collectionName).doc(uid);
      final user = docRefs.get().then(
        (DocumentSnapshot doc) => UserProfile.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>),
        onError: (e) {
          debugPrint("Error getting document: $e");
          throw DatabaseException(e);
        },
      );
      return user;
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<bool> updateUserProfile(UserProfile profile) async {
    try {
      db
          .collection(UserProfile.collectionName)
          .doc(profile.uid)
          .set(profile.toFirestore());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw DatabaseException(e.toString());
    }
  }
}
