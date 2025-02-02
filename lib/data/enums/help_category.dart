enum HelpCategory {
  elderlyHelp,
  childCare,
  petCare,
  delivery,
  other;

  String toMap() => name;

  static HelpCategory fromMap(String value) {
    return HelpCategory.values.firstWhere((category) => category.name == value);
  }
}
