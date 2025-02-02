import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteen/data/repositories/donations.dart';

part 'state.dart';

class HomeHandler extends Cubit<HomeState> {
  final DonationRepository donationRepository;
  HomeHandler({
    required this.donationRepository,
  }) : super(HomeStateInitial());
}
