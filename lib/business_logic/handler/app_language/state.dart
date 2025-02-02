part of 'handler.dart';

class AppLanguageState extends Equatable {
  final String languageCode;
  const AppLanguageState({required this.languageCode});

  @override
  List<Object> get props => [languageCode];
}
