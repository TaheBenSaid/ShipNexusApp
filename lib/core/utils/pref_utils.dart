import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/interceptor/AuthInterceptor.dart';

abstract class PrefUtils {
  String? getToken();

  String? getRefreshToken();

  void setToken(String token);

  void setRefreshToken(String refreshToken);

  void setUserId(String userId);

  void setUserName(String userName);
  String getUserName();

  void setNotificationsCounter(int counter);

  int? getNotificationsCounter();

  String? getUserId();

  void clear();

  void saveAppLanguage(String selectedLanguage);

  String? getAppLanguage();
  void setUserProfilePic(String profilePic);
  String getUserProfilePic();
  void clearAllCache();
}

@Injectable(as: PrefUtils)
class PrefUtilsImpl implements PrefUtils {
  final SharedPreferences sharedPreferences;
  final AuthenticatedHttpClient httpClientInterceptor;

  PrefUtilsImpl(
      {required this.sharedPreferences, required this.httpClientInterceptor});

  @override
  String? getToken() {
    return sharedPreferences.getString("token");
  }

  @override
  void setToken(String token) async {
    await sharedPreferences.setString("token", token);
  }

  @override
  String? getRefreshToken() {
    return sharedPreferences.getString("refreshToken");
  }

  @override
  void setRefreshToken(String refreshToken) {
    sharedPreferences.setString("refreshToken", refreshToken);
  }

  @override
  void clear() async {
    // await sharedPreferences.clear();
    sharedPreferences.remove("token");
    sharedPreferences.remove("refreshToken");
    sharedPreferences.remove("userId");
  }

  @override
  void setUserId(String userId) async {
    await sharedPreferences.setString("userId", userId);
  }

  @override
  String? getUserId() {
    return sharedPreferences.getString("userId");
  }

  @override
  void saveAppLanguage(String selectedLanguage) {
    sharedPreferences.setString("SelectedLanguage", selectedLanguage);
  }

  @override
  String? getAppLanguage() {
    return sharedPreferences.getString("SelectedLanguage");
  }

  @override
  void setUserName(String userName) {
    sharedPreferences.setString("userName", userName);
  }

  @override
  String getUserName() {
    return sharedPreferences.getString("userName")!;
  }

  @override
  void setNotificationsCounter(int counter) {
    sharedPreferences.setString(
        "user_notifications_counter", counter.toString());
  }

  @override
  int? getNotificationsCounter() {
    return int.parse(
        sharedPreferences.getString("user_notifications_counter") ?? '0');
  }

  @override
  String getUserProfilePic() {
    return sharedPreferences.getString("profilePic") ?? "";
  }

  @override
  void setUserProfilePic(String profilePic) {
    sharedPreferences.setString("profilePic", profilePic);
  }

  @override
  void clearAllCache() async {
    await sharedPreferences.clear();
  }
}
