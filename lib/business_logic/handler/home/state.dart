part of 'handler.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeStateInitial extends HomeState {}

final class HomeStateDonationsLoading extends HomeState {}

final class HomeStateDonationsSuccess extends HomeState {}

final class HomeStateDonationsFailure extends HomeState {
  final String error;

  const HomeStateDonationsFailure({required this.error});
}
