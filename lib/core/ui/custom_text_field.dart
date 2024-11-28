import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_phone_number_formatter.dart';


class CustomTextField extends StatefulWidget {
  final bool isPassword;
  final bool isNumeric;
  final bool? denySpaces;
  final String placeholder;
  final double width;
  final int maxLines;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? textColor;
  final String? Function(String?) validator;
  final TextEditingController? controller;
  final Color? filledColor;

  final bool? readOnly;

  const CustomTextField({
    Key? key,
    required this.isPassword,
    required this.isNumeric,
    required this.placeholder,
    this.width = 303,
    this.maxLines = 1,
    this.textStyle,
    this.hintStyle,
    this.textColor,
    required this.validator,
    this.controller,
    this.filledColor,
    this.readOnly = false,
    this.denySpaces,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        enabled: !widget.readOnly!,
        maxLines: widget.maxLines,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        validator: widget.validator,
        cursorColor: widget.textColor ?? Colors.white,
        obscureText: widget.isPassword ? _obscureText : false,
        inputFormatters: widget.isNumeric
            ? [CustomPhoneNumberFormatter()]
            : (widget.denySpaces == true)
            ? [
          FilteringTextInputFormatter.deny(
              RegExp(r'^\s+|\s+$')), // Deny leading and trailing spaces
        ]
            : [],
        keyboardType:
        widget.isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 12.sp,
            fontFamily: 'Outfit',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtil().radius(15)),
            borderSide: const BorderSide(
              color: Color(0xffF04438),
            ),
          ),
          filled: widget.filledColor != null,
          fillColor: widget.filledColor,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: widget.textColor ?? Colors.white,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xFFE2E8E7)),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: widget.textColor == "" ? Colors.white : const Color(0xFFE2E8E7),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: widget.placeholder,
          hintStyle:
          widget.hintStyle ?? const TextStyle(color: Color(0xFFC9C9C9)),
          suffixIcon: widget.isPassword
              ? IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: widget.textColor ?? Colors.grey,
            ),
          )
              : null,
          errorMaxLines: 2,
        ),
        style: widget.textStyle,
      ),
    );
  }
}
