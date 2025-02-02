part of 'handler.dart';

sealed class ServiceDetailedState extends Equatable {
  const ServiceDetailedState();

  @override
  List<Object> get props => [];
}

final class ServiceDetailedStateInitial extends ServiceDetailedState {}

final class ServiceDetailedStateVolunteeringLoading
    extends ServiceDetailedState {}

final class ServiceDetailedStateVolunteeringSuccess
    extends ServiceDetailedState {}

final class ServiceDetailedStateVolunteeringFailure
    extends ServiceDetailedState {
  final String error;

  const ServiceDetailedStateVolunteeringFailure({required this.error});
}

final class ServiceDetailedStateUnvolunteeringLoading
    extends ServiceDetailedState {}

final class ServiceDetailedStateUnvolunteeringSuccess
    extends ServiceDetailedState {}

final class ServiceDetailedStateUnvolunteeringFailure
    extends ServiceDetailedState {
  final String error;

  const ServiceDetailedStateUnvolunteeringFailure({required this.error});
}
