import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteen/data/models/announcement.dart';

class AnnouncementRepository {
  final FirebaseFirestore firebaseFirestore;
  AnnouncementRepository({required this.firebaseFirestore});

  Future<List<Announcement>> getAllAnnouncements() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection('announcement').get();
    return querySnapshot.docs
        .map((announcement) =>
            Announcement.fromJson(announcement.id, announcement.data()))
        .toList();
  }
}
