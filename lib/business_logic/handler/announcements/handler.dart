import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteen/data/models/announcement.dart';
import 'package:volunteen/data/repositories/announcement.dart';

part 'state.dart';

class AnnouncementsHandler extends Cubit<AnnouncementsState> {
  final AnnouncementRepository announcementRepository;
  List<Announcement> announcements = [];
  AnnouncementsHandler({required this.announcementRepository})
      : super(AnnouncementsStateInitial());

  Future<void> getAllAnnouncements() async {
    if (state is AnnouncementsStateGetAllLoading) return;
    emit(AnnouncementsStateGetAllLoading());
    try {
      announcements = await announcementRepository.getAllAnnouncements();
      emit(AnnouncementsStateGetAllSuccess());
    } on Exception catch (error) {
      emit(AnnouncementsStateGetAllFailure(error: error.toString()));
    }
  }
}
