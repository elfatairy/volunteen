import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteen/data/models/help_request.dart';
import 'package:volunteen/data/repositories/help_request.dart';

part 'state.dart';

class HelpRequestLoadHandler extends Cubit<HelpRequestLoadState> {
  final HelpRequestRepository helpRequestRepository;
  StreamSubscription<List<HelpRequest>>? _subscription;
  List<HelpRequest> userHelpRequests = [];
  HelpRequestLoadHandler({required this.helpRequestRepository})
      : super(HelpRequestLoadStateInitial());

  void listenToUserHelpRequests(final String userId) {
    _subscription?.cancel();
    emit(HelpRequestLoadStateUserHelpRequestLoading());
    _subscription =
        helpRequestRepository.getUserHelpRequestsStream(userId).listen(
      (helpRequests) {
        userHelpRequests = helpRequests;
        emit(
          HelpRequestLoadStateUserHelpRequestSuccess(
            dateTime: DateTime.now(),
          ),
        );
      },
      onError: (error) {
        emit(
          HelpRequestLoadStateUserHelpRequestFailure(
            error: error.toString(),
          ),
        );
      },
    );
  }

  Future<void> deleteHelpRequest(final String helpRequestId) async {
    emit(HelpRequestLoadStateDeleteRequestLoading());
    try {
      helpRequestRepository.deleteHelpRequest(helpRequestId);
      emit(HelpRequestLoadStateDeleteRequestSuccess());
    } on Exception catch (error) {
      emit(HelpRequestLoadStateDeleteRequestFailure(error: error.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
