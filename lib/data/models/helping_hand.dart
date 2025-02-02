// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:volunteen/data/enums/helping_hand_category.dart';

class HelpingHand {
  final String id;
  final String nameAr;
  final String nameEn;
  final String number;
  final HelpingHandCategory helpCategory;
  final String specialityAr;
  final String specialityEn;

  HelpingHand({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.number,
    required this.helpCategory,
    required this.specialityAr,
    required this.specialityEn,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name-ar': nameAr,
      'name-en': nameEn,
      'number': number,
      'category': helpCategory.toMap(),
      'speciality-ar': specialityAr,
      'speciality-en': specialityEn,
    };
  }

  factory HelpingHand.fromJson(
    final String id,
    final Map<String, dynamic> map,
  ) {
    return HelpingHand(
      id: id,
      nameAr: map['name-ar'] as String,
      nameEn: map['name-en'] as String,
      number: map['number'] as String,
      helpCategory: HelpingHandCategory.fromMap(map['category'] as String),
      specialityAr: map['speciality-ar'] as String,
      specialityEn: map['speciality-en'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
