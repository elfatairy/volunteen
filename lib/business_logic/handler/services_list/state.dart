part of 'handler.dart';

sealed class ServicesListState extends Equatable {
  const ServicesListState();

  @override
  List<Object> get props => [];
}

final class ServicesListStateInitial extends ServicesListState {}

final class ServicesListStateLoadLoading extends ServicesListState {}

final class ServicesListStateLoadSuccess extends ServicesListState {}

final class ServicesListStateLoadFailure extends ServicesListState {
  final String error;

  const ServicesListStateLoadFailure({required this.error});
}
