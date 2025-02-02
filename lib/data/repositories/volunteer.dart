import 'package:cloud_firestore/cloud_firestore.dart';

class VolunteerRepository {
  FirebaseFirestore firebaseFirestore;
  VolunteerRepository({
    required this.firebaseFirestore,
  });

  Future<void> createUserDocument(
    final String userId,
    final String name,
    final String email,
    final String whatsAppNumber,
  ) async {
    final Map<String, dynamic> userFields = {
      "email": email,
      "name": name,
      "whatsAppNumber": whatsAppNumber,
    };
    await firebaseFirestore
        .collection('users_to_be_volunteers')
        .doc(userId)
        .set(userFields);
  }
}
