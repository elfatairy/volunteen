part of 'handler.dart';

sealed class ContactUsState extends Equatable {
  const ContactUsState();

  @override
  List<Object> get props => [];
}

final class ContactUsStateInitial extends ContactUsState {}

final class ContactUsStateLoading extends ContactUsState {}

final class ContactUsStateSuccess extends ContactUsState {}

final class ContactUsStateFailure extends ContactUsState {
  final String error;

  const ContactUsStateFailure({required this.error});
}
