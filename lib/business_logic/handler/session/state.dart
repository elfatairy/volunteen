part of 'handler.dart';

sealed class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

final class SessionStateInitial extends SessionState {}

final class SessionStateAuthenticated extends SessionState {
  final DateTime dateTime;

  const SessionStateAuthenticated({
    required this.dateTime,
  });

  @override
  List<Object> get props => [dateTime];
}

final class SessionStateUnauthenticated extends SessionState {
  final DateTime dateTime;

  const SessionStateUnauthenticated({required this.dateTime});

  @override
  List<Object> get props => [dateTime];
}
