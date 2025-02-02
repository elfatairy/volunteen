import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteen/data/models/feedback.dart';

class FeedbackRepository {
  final FirebaseFirestore firebaseFirestore;
  FeedbackRepository({
    required this.firebaseFirestore,
  });

  Future<void> addFeedback(final VolunteenFeedback feedback) async {
    await firebaseFirestore.collection('feedback').doc().set(feedback.toMap());
  }
}
