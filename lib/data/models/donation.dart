// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Donation {
  String id;
  String title;
  String description;
  String location;
  String phoneNumber;
  String whatsAppNumber;
  String userId;
  Donation({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.phoneNumber,
    required this.whatsAppNumber,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'location': location,
      'phoneNumber': phoneNumber,
      'whatsAppNumber': whatsAppNumber,
      'userId': userId,
    };
  }

  factory Donation.fromJson(
    final String id,
    final Map<String, dynamic> map,
  ) {
    return Donation(
      id: id,
      title: map['title'] as String,
      description: map['description'] as String,
      location: map['location'] as String,
      phoneNumber: map['phoneNumber'] as String,
      whatsAppNumber: map['whatsAppNumber'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
