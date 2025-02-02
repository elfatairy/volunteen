import 'dart:convert';

class VolunteenFeedback {
  final String userId;
  final double rating;
  final String opinion;

  VolunteenFeedback({
    required this.userId,
    required this.rating,
    required this.opinion,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'rating': rating,
      'opinion': opinion,
    };
  }

  String toJson() => json.encode(toMap());
}
