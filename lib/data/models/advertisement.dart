class Advertisement {
  String id;
  String title;
  String description;
  String userId;
  String location;
  List<String> imagesURLs;
  double price;
  DateTime creationDate;
  DateTime updateDate;
  int phoneNumber;
  int whatsAppNumber;
  Advertisement({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.location,
    required this.imagesURLs,
    required this.price,
    required this.creationDate,
    required this.updateDate,
    required this.phoneNumber,
    required this.whatsAppNumber,
  });
}
