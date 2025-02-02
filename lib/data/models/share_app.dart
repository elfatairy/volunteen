class ShareApp {
  final String appLinkAndroid;
  final String appLinkiOS;
  final String messageAr;
  final String messageEn;

  ShareApp({
    required this.appLinkAndroid,
    required this.appLinkiOS,
    required this.messageAr,
    required this.messageEn,
  });

  factory ShareApp.fromJson(final Map<String, dynamic> map) {
    return ShareApp(
      appLinkAndroid: map['appLinkAndroid'] as String,
      appLinkiOS: map['appLinkiOS'] as String,
      messageAr: map['messageAr'] as String,
      messageEn: map['messageEn'] as String,
    );
  }
}
