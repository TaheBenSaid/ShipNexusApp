import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';

class User extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? profilePic;
  final String? phoneNumber;

  const User(
      {required this.id,
      required this.email,
      required this.phoneNumber,
      required this.profilePic,
      required this.name});

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? profilePic,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePic: profilePic ?? this.profilePic,
      name: name ?? this.name,
    );
  }

  UserModel toUserModel() {
    return UserModel(
      id: id,
      email: email,
      profilePic: profilePic,
      name: name,
      phoneNumber: phoneNumber,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNumber,
        profilePic,
      ];
}
