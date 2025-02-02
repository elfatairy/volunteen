enum HelpingHandCategory {
  mentalHealth,
  health,
  family,
  education;

  String toMap() => name;

  static HelpingHandCategory fromMap(String value) {
    return HelpingHandCategory.values
        .firstWhere((category) => category.name == value);
  }
}
