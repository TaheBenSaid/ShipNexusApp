// This function is used to validate the password in the login page...
import 'package:flutter/cupertino.dart';


String? validateEmailOrUsername(String? value, BuildContext context) {
  if (value == null || value.trim().isEmpty) {
    return "Email or username can't be blank";
  }

  // Trim the value to remove leading and trailing spaces
  final trimmedValue = value.trim();

  // Check if the value is a valid email or contains only alphanumeric characters and spaces...
  final emailRegex = RegExp(
    r"^(?:(?!@)[\w\s!#$%&'*+/=?^_`{|}~-]+(?:\.[\w\s!#$%&'*+/=?^_`{|}~-]+)*)?"
    r"[@](?:(?!@)[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*)$",
  );

  final usernameRegex = RegExp(r"^[\u0600-\u06FFa-zA-Z0-9][\u0600-\u06FFa-zA-Z0-9\s-\.]*[\u0600-\u06FFa-zA-Z0-9]$");

  if (!emailRegex.hasMatch(trimmedValue) && !usernameRegex.hasMatch(trimmedValue)) {
    return "Enter a valid email address or username";
  }

  return null;
}

String? validatePasswordForLogin(String password, BuildContext context) {
  if (password.trim().isEmpty) {
    return "Please enter password";
  }
  return null;
}
