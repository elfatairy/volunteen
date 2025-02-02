part of 'handler.dart';

sealed class SendNotificationState extends Equatable {
  const SendNotificationState();

  @override
  List<Object> get props => [];
}

final class SendNotificationStateInitial extends SendNotificationState {}

final class SendNotificationStateLoading extends SendNotificationState {}

final class SendNotificationStateSuccess extends SendNotificationState {}

final class SendNotificationStateFailure extends SendNotificationState {
  final String error;

  const SendNotificationStateFailure({required this.error});
}
