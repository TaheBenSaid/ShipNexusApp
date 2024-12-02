import 'dart:convert';
import 'package:http/http.dart';

String getErrorMessage(Response response) {
  final errorDecodedJson = json.decode(response.body) as Map<String, dynamic>;
  final error = errorDecodedJson["message"] as String;
  return error;
}
