part of 'handler.dart';

sealed class SupporterState extends Equatable {
  const SupporterState();

  @override
  List<Object> get props => [];
}

final class SupporterStateInitial extends SupporterState {}

final class SupporterStateAllLoading extends SupporterState {}

final class SupporterStateAllSuccess extends SupporterState {}

final class SupporterStateAllFailure extends SupporterState {
  final String error;

  const SupporterStateAllFailure({required this.error});
}
