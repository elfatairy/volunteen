import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteen/data/enums/help_category.dart';
import 'package:volunteen/data/models/help_request.dart';
import 'package:volunteen/data/repositories/help_request.dart';

part 'state.dart';

class ServicesListHandler extends Cubit<ServicesListState> {
  final HelpRequestRepository helpRequestRepository;
  List<HelpRequest> categoryHelpRequests = [];
  ServicesListHandler({
    required this.helpRequestRepository,
  }) : super(ServicesListStateInitial());

  Future<void> getCategoryServices(
    final HelpCategory helpCategory,
    final String userId,
  ) async {
    if (state is ServicesListStateLoadLoading) return;
    emit(ServicesListStateLoadLoading());
    try {
      categoryHelpRequests =
          await helpRequestRepository.getHelpRequestsByCategory(
        helpCategory,
        userId,
      );
      emit(ServicesListStateLoadSuccess());
    } on Exception catch (error) {
      emit(ServicesListStateLoadFailure(error: error.toString()));
    }
  }
}
