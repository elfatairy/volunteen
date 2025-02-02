class ContactUs {
  final String number;
  final String email;
  final String whatsapp;
  final String facebook;

  ContactUs({
    required this.number,
    required this.email,
    required this.whatsapp,
    required this.facebook,
  });

  factory ContactUs.fromJson(
    final Map<String, dynamic> json,
  ) {
    return ContactUs(
      number: json['number'] as String,
      email: json['email'] as String,
      whatsapp: json['whatsapp'] as String,
      facebook: json['facebook'] as String,
    );
  }
}
