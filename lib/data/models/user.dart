// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_null_comparison

import 'package:volunteen/data/enums/user_roles.dart';

class VolunteenUser {
  final String id;
  final String name;
  final String email;
  final List<UserRoles> userRoles;
  final List<String> savedDonations;
  final bool subsDonation;
  final bool subsHelpRequest;

  const VolunteenUser({
    required this.id,
    required this.name,
    required this.email,
    required this.userRoles,
    required this.savedDonations,
    required this.subsDonation,
    required this.subsHelpRequest,
  });

  static const emptyUser = VolunteenUser(
    id: '',
    name: '',
    email: '',
    userRoles: [],
    savedDonations: [],
    subsDonation: false,
    subsHelpRequest: false,
  );

  VolunteenUser copyWith({
    String? id,
    String? name,
    String? email,
    List<UserRoles>? userRoles,
    List<String>? savedDonations,
    bool? subsDonation,
    bool? subsHelpRequest,
  }) {
    return VolunteenUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      userRoles: userRoles ?? this.userRoles,
      savedDonations: savedDonations ?? this.savedDonations,
      subsDonation: subsDonation ?? this.subsDonation,
      subsHelpRequest: subsHelpRequest ?? this.subsHelpRequest,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'userRoles': userRoles.map((x) => x.name).toList(),
      'savedDonations': savedDonations,
      'subsDonation': subsDonation,
      'subsHelpRequest': subsHelpRequest,
    };
  }

  factory VolunteenUser.fromJson(
    final String id,
    final Map<String, dynamic> json,
  ) {
    return VolunteenUser(
      id: id,
      name: json['name'],
      email: json['email'],
      userRoles: parseUserRolesStringsToEnum(json['userRoles']),
      savedDonations: json['savedDonations'] == null
          ? []
          : (json['savedDonations'] as List<dynamic>)
              .map((e) => e.toString())
              .toList(),
      subsDonation: json['subsDonation'] as bool,
      subsHelpRequest: json['subsHelpRequest'] as bool,
    );
  }

  static List<UserRoles> parseUserRolesStringsToEnum(
    final List userRoles,
  ) {
    if (userRoles == null || userRoles.isEmpty) {
      return [];
    }

    return userRoles
        .where((stringRole) =>
            UserRoles.values.any((role) => role.name == stringRole))
        .map((stringRole) =>
            UserRoles.values.firstWhere((role) => role.name == stringRole))
        .toList();
  }
}
