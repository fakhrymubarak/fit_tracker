import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../profile/profile.dart';
import '../models/weight.dart';

abstract class WeightRemoteDataSource {
  Future<Stream<List<Weight>>> getListHeight(String uid);

  Future<void> insertUserWeight(String uid, Weight data);

  Future<void> updateUserWeight(String uid, Weight data);

  Future<void> deleteUserWeight(String uid, Weight data);
}

class WeightRemoteDataSourceImpl implements WeightRemoteDataSource {
  final db = FirebaseFirestore.instance;
  @override
  Future<Stream<List<Weight>>> getListHeight(String uid) async {
    try {
      final docRefs = db
          .collection(UserProfile.collectionName)
          .doc(uid)
          .collection(Weight.collectionName);

      final weights = docRefs.get().then(
        (querySnapshot) =>
            querySnapshot.docs.map((doc) => Weight.fromFirestore(doc)).toList(),
        onError: (e) {
          debugPrint("Error getting document: $e");
          throw DatabaseException(e);
        },
      );
      return weights.asStream();
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<void> insertUserWeight(String uid, Weight data) async {
    try {
      db
          .collection(UserProfile.collectionName)
          .doc(uid)
          .collection(Weight.collectionName)
          .add(data.toFirestore());
    } catch (e) {
      debugPrint(e.toString());
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> updateUserWeight(String uid, Weight data) async {
    try {
      db
          .collection(UserProfile.collectionName)
          .doc(uid)
          .collection(Weight.collectionName)
          .doc(data.id)
          .set(data.toFirestore());
    } catch (e) {
      debugPrint(e.toString());
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> deleteUserWeight(String uid, Weight data) async {
    try {
      db
          .collection(UserProfile.collectionName)
          .doc(uid)
          .collection(Weight.collectionName)
          .doc(data.id)
          .delete();
    } catch (e) {
      debugPrint(e.toString());
      throw DatabaseException(e.toString());
    }
  }
}
