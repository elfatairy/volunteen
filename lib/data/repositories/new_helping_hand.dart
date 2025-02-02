import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteen/data/models/new_helping_hand.dart';

class NewHelpingHandRepository {
  final FirebaseFirestore firebaseFirestore;
  NewHelpingHandRepository({
    required this.firebaseFirestore,
  });

  Future<void> createNewHelpingHand(final NewHelpingHand newHelpingHand) async {
    await firebaseFirestore
        .collection('new_helping_hand_request')
        .doc()
        .set(newHelpingHand.toMap());
  }
}
