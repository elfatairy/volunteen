part of 'handler.dart';

@immutable
sealed class LoginState {
  const LoginState();
}

final class LoginStateInitial extends LoginState {}

final class LoginStateLoading extends LoginState {}

final class LoginStateSuccess extends LoginState {}

final class LoginStateFailure extends LoginState {
  final String error;

  const LoginStateFailure({required this.error});
}
