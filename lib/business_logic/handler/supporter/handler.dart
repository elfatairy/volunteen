import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteen/data/models/supporter.dart';
import 'package:volunteen/data/repositories/storage.dart';
import 'package:volunteen/data/repositories/supporter.dart';

part 'state.dart';

class SupporterHandler extends Cubit<SupporterState> {
  final SupporterRepository supporterRepository;
  final StorageRepository storageRepository;
  List<Supporter> supporters = [];
  SupporterHandler({
    required this.supporterRepository,
    required this.storageRepository,
  }) : super(SupporterStateInitial());

  Future<void> getAllSupporters() async {
    emit(SupporterStateAllLoading());
    try {
      supporters = await supporterRepository.getAllSupporters();
      emit(SupporterStateAllSuccess());
    } on Exception catch (error) {
      emit(SupporterStateAllFailure(error: error.toString()));
    }
  }
}
