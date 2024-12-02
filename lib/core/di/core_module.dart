import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


@module
abstract class CoreModule {
  @lazySingleton
  http.Client get httpClient => http.Client();

  @preResolve


  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @lazySingleton
  InternetConnectionChecker get dataConnectionChecker =>
      InternetConnectionChecker();
}
