import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserWeights extends Equatable {
  static const collectionName = 'weights';

  final String uid;
  final int weight;
  final double bmi;
  final String dateTaken;

  const UserWeights({
    required this.uid,
    required this.weight,
    required this.bmi,
    required this.dateTaken,
  });

  factory UserWeights.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserWeights(
      uid: data?['uid'],
      weight: data?['weight'],
      bmi: data?['bmi'],
      dateTaken: data?['dateTaken'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "weight": weight,
      "bmi": bmi,
      "dateTaken": dateTaken,
    };
  }

  @override
  List<Object?> get props => [uid, weight];
}
