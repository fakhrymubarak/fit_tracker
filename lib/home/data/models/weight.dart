import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Weight extends Equatable {
  static const collectionName = 'weights';

  final String id;
  final String inputDate;
  final int weight;

  const Weight({
    required this.id,
    required this.inputDate,
    required this.weight,
  });

  factory Weight.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data();
    return Weight(
      id: snapshot.id,
      inputDate: data?['date'] ?? "1900-01-01",
      weight: data?['weight'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "date": inputDate,
      "weight": weight,
    };
  }

  @override
  List<Object?> get props => [inputDate, weight];
}
