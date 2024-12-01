// This function is used to validate the password in the login page...
import 'package:flutter/cupertino.dart';

String? validateField(String value, hintText, BuildContext context) {
  // Check if the input value is empty or consists only of whitespace characters.
  if (value.trim().isEmpty) {
    return "$hintText ${"can't be blank"}";
  }

  // Check if the input value contains any characters that are not letters, spaces, or Arabic characters.
  if (!value.trim().contains(RegExp(r'[a-zA-Z\u0600-\u06FF\s]+$'))) {
    return "${"That's not a valid"} $hintText ${'valide'}";
  }

  // Check if the input value contains digits or any of the specified special characters.
  if (value.trim().contains(RegExp(r'\d')) ||
      RegExp(r'[.!@#$%&*()_+=|<>?{}\[\]~-]').hasMatch(value.trim())) {
    return "${"That's not a valid"} $hintText ${'valide'}";
  }

  // If none of the above conditions are met, the input is considered valid.
  return null;
}

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

  final usernameRegex = RegExp(
      r"^[\u0600-\u06FFa-zA-Z0-9][\u0600-\u06FFa-zA-Z0-9\s-\.]*[\u0600-\u06FFa-zA-Z0-9]$");

  if (!emailRegex.hasMatch(trimmedValue) &&
      !usernameRegex.hasMatch(trimmedValue)) {
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

// Validate first name in the register screen
String? validateName(String value, BuildContext context) {
  if (value.isEmpty) {
    return "First name can't be blank";
  }
  if (value.length < 2) {
    return "First name is too short!";
  }
  if (value.length > 30) {
    return "First name is too long!";
  }

  // Allow letters, hyphens, and apostrophes, but not at the start or end
  if (!RegExp(r"^[\p{L}'-][\p{L}\s'-]*[\p{L}'-]$",
          unicode: true, caseSensitive: false)
      .hasMatch(value)) {
    return "First name can only contain letters, hyphens, and apostrophes, and can't start or end with spaces";
  }

  return null;
}

String? validateEmail(String? value, BuildContext context) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);
  if (value!.isEmpty) {
    return "Email can't be blank";
  }

  return value.isNotEmpty && !regex.hasMatch(value)
      ? "Enter a valid email address"
      : null;
}
