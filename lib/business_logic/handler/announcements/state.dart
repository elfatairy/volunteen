part of 'handler.dart';

sealed class AnnouncementsState extends Equatable {
  const AnnouncementsState();

  @override
  List<Object> get props => [];
}

final class AnnouncementsStateInitial extends AnnouncementsState {}

final class AnnouncementsStateGetAllLoading extends AnnouncementsState {}

final class AnnouncementsStateGetAllSuccess extends AnnouncementsState {}

final class AnnouncementsStateGetAllFailure extends AnnouncementsState {
  final String error;

  const AnnouncementsStateGetAllFailure({required this.error});
}
