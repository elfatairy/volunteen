import 'package:volunteen/data/enums/helping_hand_category.dart';

class NewHelpingHand {
  final String name;
  final String email;
  final HelpingHandCategory helpingHandCategory;
  final String jobDescription;
  final String phoneNumber;
  final String whatsAppNumber;

  const NewHelpingHand({
    required this.name,
    required this.email,
    required this.helpingHandCategory,
    required this.jobDescription,
    required this.phoneNumber,
    required this.whatsAppNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'helpCategory': helpingHandCategory.toMap(),
      'jobDescription': jobDescription,
      'phoneNumber': phoneNumber,
      'whatsAppNumber': whatsAppNumber,
    };
  }
}
