import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import '../../../domain/entities/user.dart';

@Entity(tableName: 'users')
class UserEntity extends Equatable {
  @PrimaryKey(autoGenerate: false)
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;

  final String? profilePic;

  const UserEntity({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.profilePic,
  });

  User toUser() {
    return User(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      profilePic: profilePic,
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
