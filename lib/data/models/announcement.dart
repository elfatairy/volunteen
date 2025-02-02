// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Announcement {
  final String id;
  final String title;
  final String content;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
    };
  }

  factory Announcement.fromJson(
    final String id,
    final Map<String, dynamic> json,
  ) {
    return Announcement(
      id: id,
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
