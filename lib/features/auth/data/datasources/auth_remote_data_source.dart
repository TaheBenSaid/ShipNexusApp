import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/handle_server_failure.dart';
import '../../../../core/network/interceptor/HttpInterceptor.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../../manage_user_feature/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);

  // Logout...
  Future<Unit> logout();

  Future<String> register(
      String name,
      String email,
      String phoneNumber,
      String password);


  // Future<List<TermsAndConditions>> getTermsAndConditions();

  Future<Map<String, dynamic>> resendCodeForgetPassword(String email);

  Future<Unit> resetCodeConfirmation(String resetCode);

  Future<Unit> confirmCodeRegister(String code, String confirmationType);

  Future<Unit> newPassword(String resetCode, String password);

  Future<Unit> mailVerification(String userId);

  Future<Unit> smsVerification(String userId);


  Future<Unit> refreshToken();
}

// Implementation of the AuthRemoteDataSource interface.
@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpInterceptor httpClient;
  final PrefUtils prefUtils;

  AuthRemoteDataSourceImpl({
    required this.httpClient,
    required this.prefUtils,
  });

  // RefreshToken...
  @override
  Future<Unit> refreshToken() async {
    final body = {"refreshToken": prefUtils.getRefreshToken()};
    final response = await httpClient
        .httpInterceptor()
        .post(Uri.parse("${BASE_URL}auth/refresh"), body: json.encode(body));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      print("decodedJson $decodedJson");
      final String accessToken = decodedJson["accessToken"];
      final String refreshToken = decodedJson["refreshToken"];
      prefUtils.setToken(accessToken);
      prefUtils.setRefreshToken(refreshToken);
      return Future.value(unit); // Successful login, return a future with unit.
    } else {
      throw ServerException(
          message: getErrorMessage(response)); // Handle server error.
    }
  }

  @override
  Future<UserModel> login(String email, String password) async {
    print("dsfsdfsdfsdf ${prefUtils.getToken()}");
    final body = {"email": email, "password": password};

    final response = await httpClient
        .httpInterceptor()
        .post(Uri.parse("$BASE_URL/auth/login"), body: json.encode(body));

    print("responseLogin${response.body}");

    if (response.statusCode == 200) {
      prefUtils.clear();
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      print(
          'login responsee ${UserModel.fromJson(decodedJson["data"]["user"])}');

      prefUtils.setToken(decodedJson["data"]["tokens"]["accessToken"]);
      prefUtils.setUserId(decodedJson["data"]["user"]["_id"]);
      prefUtils.setRefreshToken(decodedJson["data"]["tokens"]["refreshToken"]);
      prefUtils.setUserName(decodedJson["data"]["user"]['name']);
      prefUtils.setUserProfilePic(
          (decodedJson["data"]["user"]['profilePicUrl'] != null &&
                  decodedJson["data"]["user"]["profilePicUrl"]
                      .startsWith("https://"))
              ? decodedJson["data"]["user"]["profilePicUrl"]
              : "$MEDIA_URL${decodedJson["data"]["user"]["profilePicUrl"]}");
      print("accessToken ${decodedJson["data"]["tokens"]["accessToken"]}");
      print(
          "refreshTokennnnnn ${decodedJson["data"]["tokens"]["refreshToken"]}");
      final userModel = UserModel.fromJson(decodedJson["data"]["user"]);
      return userModel;
    } else {
      throw ServerException(message: getErrorMessage(response));
    }
  }

  // Logout...
  @override
  Future<Unit> logout() async {
    final response = await httpClient.httpInterceptor().delete(
          Uri.parse("$BASE_URL/auth/logout"),
        );

    if (response.statusCode == 200) {
       prefUtils.clearAllCache();
      print("logout success");
      return Future.value(unit);
    } else {
      throw ServerException(
          message: getErrorMessage(response));
    }
  }

  @override
  Future<Map<String, dynamic>> resendCodeForgetPassword(String email) async {
    late final Map<String, String> body;
    body = {
      "email": email,
    };

    final response = await httpClient.httpInterceptor().post(
          Uri.parse("$BASE_URL/auth/forget-password"),
          body: json.encode(body),
        );

    if (response.statusCode == 200) {
      print("testing forget pas ${response.body}");

      final responseData = json.decode(response.body);

      final user = responseData['data']['user'];

      final userId = user['_id'];
      final userEmail = user['email'];
      final userPhoneNumber = user['phoneNumber'];

      return {
        'userId': userId,
        'email': userEmail,
        'phoneNumber': userPhoneNumber,
      };
    } else {
      throw ServerException(
        message: getErrorMessage(response),
      );
    }
  }

  @override
  Future<Unit> resetCodeConfirmation(
    String resetCode,
  ) async {
    late final Map<String, String> body;
    body = {
      "resetCode": resetCode,
    };

    final response = await httpClient.httpInterceptor().post(
        Uri.parse("${BASE_URL}auth/reset-password"),
        body: json.encode(body));

    print('resetCodeResponse ${json.decode(response.body)}');

    if (response.statusCode == 200) {
      print("correct code");
      return Future.value(
          unit); // Successful registration, return a future with unit.
    } else {
      print("wrong code");
      throw ServerException(
          message: getErrorMessage(response)); // Handle server error.
    }
  }

  // Confirm code register screen...
  @override
  Future<Unit> confirmCodeRegister(
    String code,
    String confirmationType,
  ) async {
    late final Map<String, String> body;
    body = {
      "code": code,
      "confirmationType": confirmationType,
    };

    final response = await httpClient
        .httpInterceptor()
        .post(Uri.parse("${BASE_URL}auth/confirm"), body: json.encode(body));

    print('confirm code register ${json.decode(response.body)}');

    if (response.statusCode == 200) {
      print("correct register code");
      return Future.value(
          unit); // Successful registration, return a future with unit.
    } else {
      print("wrong register code");
      throw ServerException(
          message: getErrorMessage(response)); // Handle server error.
    }
  }

  // New password...
  @override
  Future<Unit> newPassword(
    String resetCode,
    String password,
  ) async {
    print("resetCooode: $resetCode");
    late final Map<String, String> body;
    body = {
      "resetCode": resetCode,
      "password": password,
    };

    final response = await httpClient.httpInterceptor().post(
        Uri.parse("${BASE_URL}auth/change-password"),
        body: json.encode(body));

    if (response.statusCode == 200) {
      print("new password success");
      return Future.value(
          unit); // Successful registration, return a future with unit.
    } else {
      print("new password failed");
      throw ServerException(
          message: getErrorMessage(response)); // Handle server error.
    }
  }

  // Mail Verification...
  @override
  Future<Unit> mailVerification(String userId) async {
    final response = await httpClient.httpInterceptor().post(
          Uri.parse("$BASE_URL/auth/send-email/$userId"), // Updated URL
        );

    if (response.statusCode == 200) {
      print("mail verification sent successfully");
      return Future.value(unit);
    } else {
      print("mail verification failed");
      throw ServerException(
          message: getErrorMessage(response)); // Handle server error.
    }
  }

  // Sms Verification...
  @override
  Future<Unit> smsVerification(String userId) async {
    final response = await httpClient.httpInterceptor().post(
          Uri.parse("$BASE_URL/auth/send-sms/$userId"), // Updated URL
        );

    if (response.statusCode == 200) {
      print("sms verification sent successfully");
      return Future.value(unit);
    } else {
      print("sms verification failed");
      throw ServerException(
          message: getErrorMessage(response)); // Handle server error.
    }
  }

  // Register a new user...
  @override
  Future<String> register(
      String name,
      String email,
      String phoneNumber,
      String password,
      ) async {
    late final Map<String, String> body;

      body = {
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
      };


    final response = await httpClient.httpInterceptor().post(
          Uri.parse("$BASE_URL/auth/signup"),
          body: json.encode(body),
        );

    print('request body ${(body)}');

    print('register body ${json.decode(response.body)}');
    print('register body $body');

    if (response.statusCode == 200) {
      print("testing Register response: ${response.body}");
      final responseData = json.decode(response.body);

      final userId = responseData['data']['_id'];

      print("userId $userId");
      return userId;
    } else {
      throw ServerException(
        message: getErrorMessage(response),
      );
    }
  }

}
