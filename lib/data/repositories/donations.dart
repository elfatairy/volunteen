import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteen/data/models/donation.dart';

class DonationRepository {
  final FirebaseFirestore firebaseFirestore;
  static const String donationDocumentPath = 'donation';
  DonationRepository({required this.firebaseFirestore});

  Future<String> createDonation(final Donation donation) async {
    final docRef = await firebaseFirestore
        .collection(donationDocumentPath)
        .add(donation.toMap());
    return docRef.id;
  }

  Stream<List<Donation>> getAllDonations(final String userId) {
    return firebaseFirestore
        .collection(donationDocumentPath)
        .where('userId', isNotEqualTo: userId)
        .snapshots()
        .map((snapshots) {
      return snapshots.docs
          .map((donation) => Donation.fromJson(donation.id, donation.data()))
          .toList();
    });
  }

  Future<List<Donation>> getDonations() async {
    (donation) => Donation.fromJson(donation.id, donation.data());
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection(donationDocumentPath).get();
    return querySnapshot.docs
        .map((donation) => Donation.fromJson(donation.id, donation.data()))
        .toList();
  }

  Stream<List<Donation>> getUserDonations(final String userId) {
    return firebaseFirestore
        .collection(donationDocumentPath)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshots) {
      return snapshots.docs
          .map((donation) => Donation.fromJson(donation.id, donation.data()))
          .toList();
    });
  }

  Future<void> deleteDonation(final String donationId) async {
    await firebaseFirestore
        .collection(donationDocumentPath)
        .doc(donationId)
        .delete();
  }
}
