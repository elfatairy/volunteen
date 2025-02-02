import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteen/data/models/supporter.dart';

class SupporterRepository {
  final FirebaseFirestore firebaseFirestore;
  SupporterRepository({required this.firebaseFirestore});

  Future<List<Supporter>> getAllSupporters() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection("supporter").get();
    return querySnapshot.docs
        .map((supporter) => Supporter.fromJson(supporter.id, supporter.data()))
        .toList();
  }
}
