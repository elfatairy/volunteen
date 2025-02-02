// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:volunteen/data/enums/help_category.dart';

class HelpRequest {
  String id;
  String title;
  String description;
  HelpCategory category;
  String location;
  String locationInDetails;
  String day;
  String hour;
  String phoneNumber;
  String whatsAppNumber;
  String requestedUserId;
  String? helpingUserId;
  HelpRequest({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    required this.locationInDetails,
    required this.day,
    required this.hour,
    required this.phoneNumber,
    required this.whatsAppNumber,
    required this.requestedUserId,
    this.helpingUserId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'category': category.toMap(),
      'location': location,
      'locationInDetails': locationInDetails,
      'day': day,
      'hour': hour,
      'phoneNumber': phoneNumber,
      'whatsAppNumber': whatsAppNumber,
      'requestedUserId': requestedUserId,
      'helpingUserId': helpingUserId,
    };
  }

  factory HelpRequest.fromJson(
    String id,
    Map<String, dynamic> map,
  ) {
    return HelpRequest(
      id: id,
      title: map['title'] as String,
      description: map['description'] as String,
      category: HelpCategory.fromMap(map['category'] as String),
      location: map['location'] as String,
      locationInDetails: map['locationInDetails'] as String,
      day: map['day'] as String,
      hour: map['hour'] as String,
      phoneNumber: map['phoneNumber'] as String,
      whatsAppNumber: map['whatsAppNumber'] as String,
      requestedUserId: map['requestedUserId'] as String,
      helpingUserId:
          map['helpingUserId'] != null ? map['helpingUserId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  HelpRequest copyWith({
    String? id,
    String? title,
    String? description,
    HelpCategory? category,
    String? location,
    String? locationInDetails,
    String? day,
    String? hour,
    String? phoneNumber,
    String? whatsAppNumber,
    String? requestedUserId,
    String? helpingUserId,
  }) {
    return HelpRequest(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      location: location ?? this.location,
      locationInDetails: locationInDetails ?? this.locationInDetails,
      day: day ?? this.day,
      hour: hour ?? this.hour,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      whatsAppNumber: whatsAppNumber ?? this.whatsAppNumber,
      requestedUserId: requestedUserId ?? this.requestedUserId,
      helpingUserId: helpingUserId ?? this.helpingUserId,
    );
  }
}
