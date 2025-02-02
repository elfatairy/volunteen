import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteen/data/models/contact_us.dart';

class ContactUsRepository {
  final FirebaseFirestore firebaseFirestore;
  ContactUsRepository({
    required this.firebaseFirestore,
  });

  Future<ContactUs> getContactUs() async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firebaseFirestore
            .collection("contact_us")
            .doc("contact-us")
            .get();
    return ContactUs.fromJson(documentSnapshot.data()!);
  }
}
