import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteen/data/models/user.dart';

class UserRepository {
  final FirebaseFirestore firebaseFirestore;

  UserRepository({
    required this.firebaseFirestore,
  });

  Future<VolunteenUser> getHelpingUser(final String userId) async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firebaseFirestore.collection('users').doc(userId).get();
    return VolunteenUser.fromJson(
        documentSnapshot.id, documentSnapshot.data()!);
  }

  Future<void> createUserDocument(
    final VolunteenUser user,
  ) async {
    final Map<String, dynamic> userFields = user.toJson();
    await firebaseFirestore.collection('users').doc(user.id).set(userFields);
  }

  Future<void> updateUser(
    final VolunteenUser user,
  ) async {
    final Map<String, dynamic> userFields = user.toJson();
    await firebaseFirestore.collection('users').doc(user.id).update(userFields);
  }

  Future<void> addDonation(final String userId, final String donationId) async {
    await firebaseFirestore.collection('users').doc(userId).set(
      {
        "savedDonations": FieldValue.arrayUnion([donationId]),
      },
      SetOptions(merge: true),
    );
  }

  Future<void> removeDonation(
      final String userId, final String donationId) async {
    await firebaseFirestore.collection('users').doc(userId).set(
      {
        "savedDonations": FieldValue.arrayRemove([donationId]),
      },
      SetOptions(merge: true),
    );
  }

  Future<void> updateSubsDonation(
    final String userId,
    final bool subsDonation,
  ) async {
    await firebaseFirestore
        .collection('users')
        .doc(userId)
        .set({"subsDonation": subsDonation}, SetOptions(merge: true));
  }

  Future<void> updateSubsHelpRequest(
      final String userId, final bool subsHelpRequest) async {
    await firebaseFirestore
        .collection('users')
        .doc(userId)
        .set({"subsHelpRequest": subsHelpRequest}, SetOptions(merge: true));
  }

  Future<void> deleteUser(
    final String userId,
  ) async {
    await firebaseFirestore.collection('users').doc(userId).delete();
  }
}
