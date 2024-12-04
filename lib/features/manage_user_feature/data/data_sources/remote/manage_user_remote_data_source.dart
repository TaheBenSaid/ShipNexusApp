import 'dart:convert';
import 'package:injectable/injectable.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/errors/exception.dart';
import '../../../../../core/network/interceptor/HttpInterceptor.dart';
import '../../../../../core/errors/handle_server_failure.dart';
import '../../models/user_model.dart';

abstract class ManageUserRemoteDataSource {
  Future<UserModel> getRemoteUser();
}

@Injectable(as: ManageUserRemoteDataSource)
class ManageUserRemoteDataSourceImpl extends ManageUserRemoteDataSource {
  final HttpInterceptor httpClient;

  ManageUserRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<UserModel> getRemoteUser() async {
    final response = await httpClient
        .httpInterceptor()
        .get(Uri.parse("${BASE_URL}users/me"));
    print("getRemoteUser${response.body}");
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body)["data"];
      final UserModel userModel = UserModel.fromJson(decodedJson);
      print("getRemoteUserddddd $userModel");

      return userModel;
    } else {
      throw ServerException(message: getErrorMessage(response));
    }
  }
}
