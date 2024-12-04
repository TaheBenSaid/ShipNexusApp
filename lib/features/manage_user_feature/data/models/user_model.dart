
import '../../../../core/constants.dart';
import '../../domain/entities/user.dart';
import '../data_sources/locale/user_entity.dart';

class UserModel extends User {
  const UserModel(
      {required String? id,
      required String? email,
      required String? phoneNumber,
      required String? profilePic,
      required String? name})
      : super(
          id: id,
          email: email,
          phoneNumber: phoneNumber,
          profilePic: profilePic,
          name: name,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) {


    return UserModel(
        id: json['_id'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        profilePic: (json['profilePicUrl'] != null &&
                json['profilePicUrl'].startsWith('https://'))
            ? json['profilePicUrl']
            : "$MEDIA_URL${json['profilePicUrl']}",
        name: json['name'],
    );
  }

  UserEntity toUserEntity() {
    return UserEntity(
      id: id,
      email: email,
      phoneNumber: phoneNumber,
      profilePic: profilePic,
      name: name,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['profilePicUrl'] = profilePic;
    return data;
  }
}
