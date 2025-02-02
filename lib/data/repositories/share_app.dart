import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteen/data/models/share_app.dart';

class ShareAppRepository {
  final FirebaseFirestore firebaseFirestore;
  ShareAppRepository({
    required this.firebaseFirestore,
  });

  Future<ShareApp> getAppLink() async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firebaseFirestore.collection('share_app').doc('share-app').get();

    return ShareApp.fromJson(documentSnapshot.data()!);
  }
}
