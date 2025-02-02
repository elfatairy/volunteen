// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routes.dart';

/// generated route for
/// [AccountEmptyScreen]
class AccountEmptyRoute extends PageRouteInfo<void> {
  const AccountEmptyRoute({List<PageRouteInfo>? children})
      : super(AccountEmptyRoute.name, initialChildren: children);

  static const String name = 'AccountEmptyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AccountEmptyScreen();
    },
  );
}

/// generated route for
/// [AccountScreen]
class AccountRoute extends PageRouteInfo<void> {
  const AccountRoute({List<PageRouteInfo>? children})
      : super(AccountRoute.name, initialChildren: children);

  static const String name = 'AccountRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AccountScreen();
    },
  );
}

/// generated route for
/// [AccountTypeEmptyScreen]
class AccountTypeEmptyRoute extends PageRouteInfo<void> {
  const AccountTypeEmptyRoute({List<PageRouteInfo>? children})
      : super(AccountTypeEmptyRoute.name, initialChildren: children);

  static const String name = 'AccountTypeEmptyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AccountTypeEmptyScreen();
    },
  );
}

/// generated route for
/// [AccountTypeScreen]
class AccountTypeRoute extends PageRouteInfo<AccountTypeRouteArgs> {
  AccountTypeRoute({
    Key? key,
    required String name,
    required String email,
    required String password,
    List<PageRouteInfo>? children,
  }) : super(
          AccountTypeRoute.name,
          args: AccountTypeRouteArgs(
            key: key,
            name: name,
            email: email,
            password: password,
          ),
          initialChildren: children,
        );

  static const String name = 'AccountTypeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AccountTypeRouteArgs>();
      return AccountTypeScreen(
        key: args.key,
        name: args.name,
        email: args.email,
        password: args.password,
      );
    },
  );
}

class AccountTypeRouteArgs {
  const AccountTypeRouteArgs({
    this.key,
    required this.name,
    required this.email,
    required this.password,
  });

  final Key? key;

  final String name;

  final String email;

  final String password;

  @override
  String toString() {
    return 'AccountTypeRouteArgs{key: $key, name: $name, email: $email, password: $password}';
  }
}

/// generated route for
/// [AnnouncementsScreen]
class AnnouncementsRoute extends PageRouteInfo<void> {
  const AnnouncementsRoute({List<PageRouteInfo>? children})
      : super(AnnouncementsRoute.name, initialChildren: children);

  static const String name = 'AnnouncementsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AnnouncementsScreen();
    },
  );
}

/// generated route for
/// [ContactUsScreen]
class ContactUsRoute extends PageRouteInfo<void> {
  const ContactUsRoute({List<PageRouteInfo>? children})
      : super(ContactUsRoute.name, initialChildren: children);

  static const String name = 'ContactUsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ContactUsScreen();
    },
  );
}

/// generated route for
/// [DetailedDonationScreen]
class DetailedDonationRoute extends PageRouteInfo<DetailedDonationRouteArgs> {
  DetailedDonationRoute({
    Key? key,
    required Donation donation,
    List<PageRouteInfo>? children,
  }) : super(
          DetailedDonationRoute.name,
          args: DetailedDonationRouteArgs(key: key, donation: donation),
          initialChildren: children,
        );

  static const String name = 'DetailedDonationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DetailedDonationRouteArgs>();
      return DetailedDonationScreen(key: args.key, donation: args.donation);
    },
  );
}

class DetailedDonationRouteArgs {
  const DetailedDonationRouteArgs({this.key, required this.donation});

  final Key? key;

  final Donation donation;

  @override
  String toString() {
    return 'DetailedDonationRouteArgs{key: $key, donation: $donation}';
  }
}

/// generated route for
/// [DonationsEmptyScreen]
class DonationsEmptyRoute extends PageRouteInfo<void> {
  const DonationsEmptyRoute({List<PageRouteInfo>? children})
      : super(DonationsEmptyRoute.name, initialChildren: children);

  static const String name = 'DonationsEmptyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DonationsEmptyScreen();
    },
  );
}

/// generated route for
/// [DonationsScreen]
class DonationsRoute extends PageRouteInfo<void> {
  const DonationsRoute({List<PageRouteInfo>? children})
      : super(DonationsRoute.name, initialChildren: children);

  static const String name = 'DonationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DonationsScreen();
    },
  );
}

/// generated route for
/// [FeedbackScreen]
class FeedbackRoute extends PageRouteInfo<FeedbackRouteArgs> {
  FeedbackRoute({Key? key, List<PageRouteInfo>? children})
      : super(
          FeedbackRoute.name,
          args: FeedbackRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'FeedbackRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FeedbackRouteArgs>(
        orElse: () => const FeedbackRouteArgs(),
      );
      return FeedbackScreen(key: args.key);
    },
  );
}

class FeedbackRouteArgs {
  const FeedbackRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'FeedbackRouteArgs{key: $key}';
  }
}

/// generated route for
/// [HelpRequestDetailScreen]
class HelpRequestDetailRoute extends PageRouteInfo<HelpRequestDetailRouteArgs> {
  HelpRequestDetailRoute({
    Key? key,
    required HelpRequest helpRequest,
    List<PageRouteInfo>? children,
  }) : super(
          HelpRequestDetailRoute.name,
          args: HelpRequestDetailRouteArgs(key: key, helpRequest: helpRequest),
          initialChildren: children,
        );

  static const String name = 'HelpRequestDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HelpRequestDetailRouteArgs>();
      return HelpRequestDetailScreen(
        key: args.key,
        helpRequest: args.helpRequest,
      );
    },
  );
}

class HelpRequestDetailRouteArgs {
  const HelpRequestDetailRouteArgs({this.key, required this.helpRequest});

  final Key? key;

  final HelpRequest helpRequest;

  @override
  String toString() {
    return 'HelpRequestDetailRouteArgs{key: $key, helpRequest: $helpRequest}';
  }
}

/// generated route for
/// [HelpRequestsEmptyScreen]
class HelpRequestsEmptyRoute extends PageRouteInfo<void> {
  const HelpRequestsEmptyRoute({List<PageRouteInfo>? children})
      : super(HelpRequestsEmptyRoute.name, initialChildren: children);

  static const String name = 'HelpRequestsEmptyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HelpRequestsEmptyScreen();
    },
  );
}

/// generated route for
/// [HelpRequestsScreen]
class HelpRequestsRoute extends PageRouteInfo<void> {
  const HelpRequestsRoute({List<PageRouteInfo>? children})
      : super(HelpRequestsRoute.name, initialChildren: children);

  static const String name = 'HelpRequestsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HelpRequestsScreen();
    },
  );
}

/// generated route for
/// [HelpingHandsScreen]
class HelpingHandsRoute extends PageRouteInfo<HelpingHandsRouteArgs> {
  HelpingHandsRoute({
    Key? key,
    required HelpingHandCategory helpingHandCategory,
    List<PageRouteInfo>? children,
  }) : super(
          HelpingHandsRoute.name,
          args: HelpingHandsRouteArgs(
            key: key,
            helpingHandCategory: helpingHandCategory,
          ),
          initialChildren: children,
        );

  static const String name = 'HelpingHandsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HelpingHandsRouteArgs>();
      return HelpingHandsScreen(
        key: args.key,
        helpingHandCategory: args.helpingHandCategory,
      );
    },
  );
}

class HelpingHandsRouteArgs {
  const HelpingHandsRouteArgs({this.key, required this.helpingHandCategory});

  final Key? key;

  final HelpingHandCategory helpingHandCategory;

  @override
  String toString() {
    return 'HelpingHandsRouteArgs{key: $key, helpingHandCategory: $helpingHandCategory}';
  }
}

/// generated route for
/// [HomeEmptyScreen]
class HomeEmptyRoute extends PageRouteInfo<void> {
  const HomeEmptyRoute({List<PageRouteInfo>? children})
      : super(HomeEmptyRoute.name, initialChildren: children);

  static const String name = 'HomeEmptyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeEmptyScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [LandingEmptyScreen]
class LandingEmptyRoute extends PageRouteInfo<void> {
  const LandingEmptyRoute({List<PageRouteInfo>? children})
      : super(LandingEmptyRoute.name, initialChildren: children);

  static const String name = 'LandingEmptyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LandingEmptyScreen();
    },
  );
}

/// generated route for
/// [LandingScreen]
class LandingRoute extends PageRouteInfo<void> {
  const LandingRoute({List<PageRouteInfo>? children})
      : super(LandingRoute.name, initialChildren: children);

  static const String name = 'LandingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LandingScreen();
    },
  );
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({Key? key, List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return LoginScreen(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}

/// generated route for
/// [NewHelpingHandScreen]
class NewHelpingHandRoute extends PageRouteInfo<NewHelpingHandRouteArgs> {
  NewHelpingHandRoute({Key? key, List<PageRouteInfo>? children})
      : super(
          NewHelpingHandRoute.name,
          args: NewHelpingHandRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'NewHelpingHandRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewHelpingHandRouteArgs>(
        orElse: () => const NewHelpingHandRouteArgs(),
      );
      return NewHelpingHandScreen(key: args.key);
    },
  );
}

class NewHelpingHandRouteArgs {
  const NewHelpingHandRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'NewHelpingHandRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SavedDonationsEmptyScreen]
class SavedDonationsEmptyRoute extends PageRouteInfo<void> {
  const SavedDonationsEmptyRoute({List<PageRouteInfo>? children})
      : super(SavedDonationsEmptyRoute.name, initialChildren: children);

  static const String name = 'SavedDonationsEmptyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SavedDonationsEmptyScreen();
    },
  );
}

/// generated route for
/// [SavedDonationsScreen]
class SavedDonationsRoute extends PageRouteInfo<void> {
  const SavedDonationsRoute({List<PageRouteInfo>? children})
      : super(SavedDonationsRoute.name, initialChildren: children);

  static const String name = 'SavedDonationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SavedDonationsScreen();
    },
  );
}

/// generated route for
/// [ServiceDetailedScreen]
class ServiceDetailedRoute extends PageRouteInfo<ServiceDetailedRouteArgs> {
  ServiceDetailedRoute({
    Key? key,
    required HelpRequest helpRequest,
    required String userId,
    List<PageRouteInfo>? children,
  }) : super(
          ServiceDetailedRoute.name,
          args: ServiceDetailedRouteArgs(
            key: key,
            helpRequest: helpRequest,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'ServiceDetailedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ServiceDetailedRouteArgs>();
      return ServiceDetailedScreen(
        key: args.key,
        helpRequest: args.helpRequest,
        userId: args.userId,
      );
    },
  );
}

class ServiceDetailedRouteArgs {
  const ServiceDetailedRouteArgs({
    this.key,
    required this.helpRequest,
    required this.userId,
  });

  final Key? key;

  final HelpRequest helpRequest;

  final String userId;

  @override
  String toString() {
    return 'ServiceDetailedRouteArgs{key: $key, helpRequest: $helpRequest, userId: $userId}';
  }
}

/// generated route for
/// [ServicesEmptyScreen]
class ServicesEmptyRoute extends PageRouteInfo<void> {
  const ServicesEmptyRoute({List<PageRouteInfo>? children})
      : super(ServicesEmptyRoute.name, initialChildren: children);

  static const String name = 'ServicesEmptyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ServicesEmptyScreen();
    },
  );
}

/// generated route for
/// [ServicesListEmptyScreen]
class ServicesListEmptyRoute extends PageRouteInfo<void> {
  const ServicesListEmptyRoute({List<PageRouteInfo>? children})
      : super(ServicesListEmptyRoute.name, initialChildren: children);

  static const String name = 'ServicesListEmptyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ServicesListEmptyScreen();
    },
  );
}

/// generated route for
/// [ServicesListScreen]
class ServicesListRoute extends PageRouteInfo<ServicesListRouteArgs> {
  ServicesListRoute({
    Key? key,
    required HelpCategory helpCategory,
    List<PageRouteInfo>? children,
  }) : super(
          ServicesListRoute.name,
          args: ServicesListRouteArgs(key: key, helpCategory: helpCategory),
          initialChildren: children,
        );

  static const String name = 'ServicesListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ServicesListRouteArgs>();
      return ServicesListScreen(key: args.key, helpCategory: args.helpCategory);
    },
  );
}

class ServicesListRouteArgs {
  const ServicesListRouteArgs({this.key, required this.helpCategory});

  final Key? key;

  final HelpCategory helpCategory;

  @override
  String toString() {
    return 'ServicesListRouteArgs{key: $key, helpCategory: $helpCategory}';
  }
}

/// generated route for
/// [ServicesScreen]
class ServicesRoute extends PageRouteInfo<void> {
  const ServicesRoute({List<PageRouteInfo>? children})
      : super(ServicesRoute.name, initialChildren: children);

  static const String name = 'ServicesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ServicesScreen();
    },
  );
}

/// generated route for
/// [SignUpEmptyScreen]
class SignUpEmptyRoute extends PageRouteInfo<void> {
  const SignUpEmptyRoute({List<PageRouteInfo>? children})
      : super(SignUpEmptyRoute.name, initialChildren: children);

  static const String name = 'SignUpEmptyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignUpEmptyScreen();
    },
  );
}

/// generated route for
/// [SignUpScreen]
class SignUpRoute extends PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({Key? key, List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignUpRouteArgs>(
        orElse: () => const SignUpRouteArgs(),
      );
      return SignUpScreen(key: args.key);
    },
  );
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SubmitDonationScreen]
class SubmitDonationRoute extends PageRouteInfo<SubmitDonationRouteArgs> {
  SubmitDonationRoute({Key? key, List<PageRouteInfo>? children})
      : super(
          SubmitDonationRoute.name,
          args: SubmitDonationRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SubmitDonationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SubmitDonationRouteArgs>(
        orElse: () => const SubmitDonationRouteArgs(),
      );
      return SubmitDonationScreen(key: args.key);
    },
  );
}

class SubmitDonationRouteArgs {
  const SubmitDonationRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SubmitDonationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SubmitHelpRequestScreen]
class SubmitHelpRequestRoute extends PageRouteInfo<SubmitHelpRequestRouteArgs> {
  SubmitHelpRequestRoute({
    Key? key,
    required HelpCategory helpCategory,
    List<PageRouteInfo>? children,
  }) : super(
          SubmitHelpRequestRoute.name,
          args:
              SubmitHelpRequestRouteArgs(key: key, helpCategory: helpCategory),
          initialChildren: children,
        );

  static const String name = 'SubmitHelpRequestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SubmitHelpRequestRouteArgs>();
      return SubmitHelpRequestScreen(
        key: args.key,
        helpCategory: args.helpCategory,
      );
    },
  );
}

class SubmitHelpRequestRouteArgs {
  const SubmitHelpRequestRouteArgs({this.key, required this.helpCategory});

  final Key? key;

  final HelpCategory helpCategory;

  @override
  String toString() {
    return 'SubmitHelpRequestRouteArgs{key: $key, helpCategory: $helpCategory}';
  }
}

/// generated route for
/// [SupportesScreen]
class SupportesRoute extends PageRouteInfo<void> {
  const SupportesRoute({List<PageRouteInfo>? children})
      : super(SupportesRoute.name, initialChildren: children);

  static const String name = 'SupportesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SupportesScreen();
    },
  );
}

/// generated route for
/// [UserDonationEmptyScreen]
class UserDonationEmptyRoute extends PageRouteInfo<void> {
  const UserDonationEmptyRoute({List<PageRouteInfo>? children})
      : super(UserDonationEmptyRoute.name, initialChildren: children);

  static const String name = 'UserDonationEmptyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserDonationEmptyScreen();
    },
  );
}

/// generated route for
/// [UserDonationScreen]
class UserDonationRoute extends PageRouteInfo<void> {
  const UserDonationRoute({List<PageRouteInfo>? children})
      : super(UserDonationRoute.name, initialChildren: children);

  static const String name = 'UserDonationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserDonationScreen();
    },
  );
}

/// generated route for
/// [WhatsAppNumberScreen]
class WhatsAppNumberRoute extends PageRouteInfo<WhatsAppNumberRouteArgs> {
  WhatsAppNumberRoute({
    Key? key,
    required String name,
    required String email,
    required String password,
    required SignupHandler signupHandler,
    List<PageRouteInfo>? children,
  }) : super(
          WhatsAppNumberRoute.name,
          args: WhatsAppNumberRouteArgs(
            key: key,
            name: name,
            email: email,
            password: password,
            signupHandler: signupHandler,
          ),
          initialChildren: children,
        );

  static const String name = 'WhatsAppNumberRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WhatsAppNumberRouteArgs>();
      return WhatsAppNumberScreen(
        key: args.key,
        name: args.name,
        email: args.email,
        password: args.password,
        signupHandler: args.signupHandler,
      );
    },
  );
}

class WhatsAppNumberRouteArgs {
  const WhatsAppNumberRouteArgs({
    this.key,
    required this.name,
    required this.email,
    required this.password,
    required this.signupHandler,
  });

  final Key? key;

  final String name;

  final String email;

  final String password;

  final SignupHandler signupHandler;

  @override
  String toString() {
    return 'WhatsAppNumberRouteArgs{key: $key, name: $name, email: $email, password: $password, signupHandler: $signupHandler}';
  }
}
