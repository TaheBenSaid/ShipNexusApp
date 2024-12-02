import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/interceptor/AuthInterceptor.dart';

abstract class PrefUtils {
  String? getToken();

  String? getRefreshToken();

  Object? getArguments();
  void setArguments(Object arguments);

  void setToken(String token);

  void setRefreshToken(String refreshToken);

  void setUserId(String userId);

  void setUserRole(String userId);
  void setUserName(String userName);
  String getUserName();

  void setIdUserRole(String userId);

  void registerTryout(String newTryout);

  void setNotificationsCounter(int counter);

  int? getNotificationsCounter();

  bool checkAndDeleteTryout(String searchTryout);

  String? getUserId();

  String? getUserRole();

  String? getIdUserRole();

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
    sharedPreferences.remove("userRole");
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
  void setUserRole(String userRole) {
    sharedPreferences.setString("userRole", userRole);
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
  void setIdUserRole(String userRole) {
    sharedPreferences.setString("idUserRole", userRole);
  }

  @override
  void registerTryout(String newTryout) {
    List<String>? existingStrings =
        sharedPreferences.getStringList('my_tryout_join_requests') ?? [];
    existingStrings.add(newTryout);
    sharedPreferences.setStringList('my_tryout_join_requests', existingStrings);
  }

  @override
  void setNotificationsCounter(int counter) {
    sharedPreferences.setString(
        "user_notifications_counter", counter.toString());
  }

  @override
  bool checkAndDeleteTryout(String searchTryout) {
    List<String>? existingStrings =
        sharedPreferences.getStringList('my_tryout_join_requests') ?? [];
    if (existingStrings.contains(searchTryout)) {
      existingStrings.remove(searchTryout);
      sharedPreferences.setStringList(
          'my_tryout_join_requests', existingStrings);
      return true;
    }
    return false;
  }

  @override
  String? getUserRole() {
    return sharedPreferences.getString("userRole");
  }

  @override
  int? getNotificationsCounter() {
    return int.parse(
        sharedPreferences.getString("user_notifications_counter") ?? '0');
  }

  @override
  String? getIdUserRole() {
    return sharedPreferences.getString("idUserRole");
  }

  @override
  Object? getArguments() {
    String? argumentsString = sharedPreferences.getString("arguments");
    return int.parse(argumentsString!);
  }

  @override
  void setArguments(Object arguments) {
    sharedPreferences.setString("arguments", arguments.toString());

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
