import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteen/data/enums/helping_hand_category.dart';
import 'package:volunteen/data/models/helping_hand.dart';

class HelpingHandRepository {
  final FirebaseFirestore firebaseFirestore;
  static const String helpingHandDocumentPath = 'helping_hand';

  HelpingHandRepository({required this.firebaseFirestore});

  Future<List<HelpingHand>> getHelpingHandsForCategory(
      final HelpingHandCategory helpingHandCategory) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore
            .collection(helpingHandDocumentPath)
            .where('category', isEqualTo: helpingHandCategory.toMap())
            .get();

    return querySnapshot.docs.map((helpingHand) {
      return HelpingHand.fromJson(helpingHand.id, helpingHand.data());
    }).toList();
  }
}
