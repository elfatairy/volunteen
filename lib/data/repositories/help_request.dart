import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteen/data/enums/help_category.dart';
import 'package:volunteen/data/models/help_request.dart';

class HelpRequestRepository {
  final FirebaseFirestore firebaseFirestore;
  static const String helpRequestDocumentPath = 'help_request';

  HelpRequestRepository({required this.firebaseFirestore});

  Stream<List<HelpRequest>> getUserHelpRequestsStream(final String userId) {
    return firebaseFirestore
        .collection(helpRequestDocumentPath)
        .where('requestedUserId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => HelpRequest.fromJson(doc.id, doc.data()))
          .toList();
    });
  }

  Stream<List<HelpRequest>> getUserProvidedHelp(final String userId) {
    return firebaseFirestore
        .collection(helpRequestDocumentPath)
        .where('helpingUserId', isEqualTo: userId)
        .snapshots()
        .map((snapshots) {
      return snapshots.docs
          .map((request) => HelpRequest.fromJson(request.id, request.data()))
          .toList();
    });
  }

  Future<List<HelpRequest>> getHelpRequestsByCategory(
    final HelpCategory helpCategory,
    final String userId,
  ) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore
              .collection(helpRequestDocumentPath)
              .where('category', isEqualTo: helpCategory.toMap())
              .get();

      final List<HelpRequest> helpRequests = querySnapshot.docs
          .where((doc) {
            final data = doc.data();
            final helpingUserId = data['helpingUserId'];
            final requestedUserId = data['requestedUserId'];
            return (helpingUserId == null || helpingUserId == userId) &&
                requestedUserId != userId;
          })
          .map((doc) => HelpRequest.fromJson(doc.id, doc.data()))
          .toList();

      final uniqueHelpRequests = {
        for (var request in helpRequests) request.id: request,
      }.values.toList();

      return uniqueHelpRequests;
    } catch (e) {
      throw Exception('Failed to fetch help requests');
    }
  }

  Future<void> addHelpingUserId(
    final String helpRequestId,
    final String helpingUserId,
  ) async {
    await firebaseFirestore
        .collection(helpRequestDocumentPath)
        .doc(helpRequestId)
        .set(
      {
        "helpingUserId": helpingUserId,
      },
      SetOptions(merge: true),
    );
  }

  Future<void> removeHelpingUserId(
    final String helpRequestId,
    final String helpingUserId,
  ) async {
    await firebaseFirestore
        .collection(helpRequestDocumentPath)
        .doc(helpRequestId)
        .set(
      {
        "helpingUserId": null,
      },
      SetOptions(merge: true),
    );
  }

  Future<void> createHelpRequest(final HelpRequest helpRequest) async {
    await firebaseFirestore
        .collection(helpRequestDocumentPath)
        .doc()
        .set(helpRequest.toMap());
  }

  Future<void> deleteHelpRequest(final String helpRequestId) async {
    await firebaseFirestore
        .collection(helpRequestDocumentPath)
        .doc(helpRequestId)
        .delete();
  }
}
