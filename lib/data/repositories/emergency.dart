import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyRepository {
  final FirebaseFirestore firebaseFirestore;
  EmergencyRepository({
    required this.firebaseFirestore,
  });

  Future<String> getEmergencyNumber() async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firebaseFirestore.collection("emergency").doc("emergency").get();
    return documentSnapshot.data()!['number'] as String;
  }
}
