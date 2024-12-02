import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../injection.dart';


@Singleton()
class AuthenticatedHttpClient extends InterceptorContract {
  SharedPreferences sharedPref;

  AuthenticatedHttpClient({required this.sharedPref});

  String get userAccessToken {
    sharedPref = getIt.get<SharedPreferences>();
    return sharedPref.getString("token") ?? "";
  }

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {

    // intercept each call and add the Authorization header if token is available
    data.headers['Content-Type'] = 'application/json; charset=utf-8';
    data.headers['Accept'] = 'application/json';

    if (userAccessToken.isNotEmpty) {
      data.headers['Authorization'] = 'Bearer $userAccessToken';
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}
