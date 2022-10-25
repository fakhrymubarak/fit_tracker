import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../profile/profile.dart';
import '../models/weight.dart';

abstract class WeightRemoteDataSource {
  Future<List<Weight>> getListHeight(String uid);
}

class WeightRemoteDataSourceImpl implements WeightRemoteDataSource {
  @override
  Future<List<Weight>> getListHeight(String uid) async {
    final db = FirebaseFirestore.instance;
    try {
      final docRefs = db
          .collection(UserProfile.collectionName)
          .doc(uid)
          .collection(Weight.collectionName);
      final weights = docRefs.get().then(
        (querySnapshot) => querySnapshot.docs
            .map(
              (doc) => Weight.fromFirestore(doc),
            )
            .toList(),
        onError: (e) {
          debugPrint("Error getting document: $e");
          throw DatabaseException(e);
        },
      );
      return weights;
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }
}
