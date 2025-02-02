class Supporter {
  final String id;
  final String nameAr;
  final String nameEn;

  Supporter({required this.id, required this.nameAr, required this.nameEn});

  factory Supporter.fromJson(final String id, final Map<String, dynamic> json) {
    return Supporter(
      id: id,
      nameAr: json['name-ar'] as String,
      nameEn: json['name-en'] as String,
    );
  }
}
