import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteen/data/models/user.dart';
import 'package:volunteen/data/repositories/help_request.dart';
import 'package:volunteen/data/repositories/user.dart';

part 'state.dart';

class HelpRequestDetailedHandler extends Cubit<HelpRequestDetailedState> {
  final UserRepository userRepository;
  final HelpRequestRepository helpRequestRepository;
  VolunteenUser volunteenUser = VolunteenUser.emptyUser;
  HelpRequestDetailedHandler({
    required this.userRepository,
    required this.helpRequestRepository,
  }) : super(HelpRequestDetailedStateInitial());

  Future<void> getVolunteenUser(final String userId) async {
    if (state is HelpRequestDetailedStateUserLoading) return;
    emit(HelpRequestDetailedStateUserLoading());
    try {
      volunteenUser = await userRepository.getHelpingUser(userId);
      emit(HelpRequestDetailedStateUserSuccess());
    } on Exception catch (error) {
      emit(HelpRequestDetailedStateUserFailure(error: error.toString()));
    }
  }

  Future<void> deleteHelpRequest(
    final String helpRequestId,
  ) async {
    emit(HelpRequestDetailedStateDeleteLoading());
    try {
      helpRequestRepository.deleteHelpRequest(helpRequestId);
      emit(HelpRequestDetailedStateDeleteSuccess());
    } on Exception catch (error) {
      emit(HelpRequestDetailedStateDeleteFailure(error: error.toString()));
    }
  }
}
