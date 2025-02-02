part of 'handler.dart';

sealed class CreateDonationState extends Equatable {
  const CreateDonationState();

  @override
  List<Object> get props => [];
}

final class CreateDonationHandlerStateInitial extends CreateDonationState {}

final class CreateDonationHandlerStateLoading extends CreateDonationState {}

final class CreateDonationHandlerStateSuccess extends CreateDonationState {}

final class CreateDonationHandlerStateFailure extends CreateDonationState {
  final String error;

  const CreateDonationHandlerStateFailure({required this.error});
}

final class CreateDonationHandlerStateImageUploadLoading
    extends CreateDonationState {}

final class CreateDonationHandlerStateImageUploadSuccess
    extends CreateDonationState {}

final class CreateDonationHandlerStateImageUploadFailure
    extends CreateDonationState {
  final String error;

  const CreateDonationHandlerStateImageUploadFailure({required this.error});
}
