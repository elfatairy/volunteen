import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteen/data/repositories/help_request.dart';

part 'state.dart';

class ServiceDetailedHandler extends Cubit<ServiceDetailedState> {
  final HelpRequestRepository helpRequestRepository;
  ServiceDetailedHandler({
    required this.helpRequestRepository,
  }) : super(ServiceDetailedStateInitial());

  Future<void> addHelpingUserId(
    final String helpRequestId,
    final String helpingUserId,
  ) async {
    if (state is ServiceDetailedStateVolunteeringLoading) return;
    emit(ServiceDetailedStateVolunteeringLoading());

    try {
      await helpRequestRepository.addHelpingUserId(
          helpRequestId, helpingUserId);
      emit(ServiceDetailedStateVolunteeringSuccess());
    } on Exception catch (error) {
      emit(ServiceDetailedStateVolunteeringFailure(error: error.toString()));
    }
  }

  Future<void> removeHelpingUserId(
    final String helpRequestId,
    final String helpingUserId,
  ) async {
    if (state is ServiceDetailedStateVolunteeringLoading) return;
    emit(ServiceDetailedStateVolunteeringLoading());

    try {
      await helpRequestRepository.removeHelpingUserId(
          helpRequestId, helpingUserId);
      emit(ServiceDetailedStateVolunteeringSuccess());
    } on Exception catch (error) {
      emit(ServiceDetailedStateVolunteeringFailure(error: error.toString()));
    }
  }
}
