import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shipnexusapp/core/ui/colors/colors.dart';
import 'package:shipnexusapp/features/auth/presentation/pages/signin_screen.dart';

import '../../../../core/ui/custom_text_field.dart';
import '../../../../core/validations/input_validations.dart';
import '../widgets/custom_back_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppConstants.primaryColor,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 65.h,
                ),
                CustomBackButton(
                  text: 'Sign Up',
                ),
                SizedBox(
                  height: 15.h,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 0.887.sh,
                    clipBehavior: Clip.antiAlias,
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 34.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 40.h,
                            ),
                            // Welcome Text...
                            Transform.translate(
                              offset: const Offset(20, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Welcome to us,',
                                        style: TextStyle(
                                          color: Color(0xFF9BCCF3),
                                          fontSize: 24.sp,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Hello there, create New account',
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 12.sp,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  Transform.translate(
                                    offset: const Offset(20, -30),
                                    child: Image.asset(
                                      'assets/images/app_logo_blue.png',
                                      width: 120.w,
                                      height: 120.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Form...
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  // Name Text Field...
                                  Container(
                                    margin: EdgeInsets.only(bottom: 21.0.h),
                                    child: CustomTextField(
                                      controller: _nameController,
                                      isPassword: false,
                                      placeholder: "Name",
                                      width: double.infinity,
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      isNumeric: false,
                                      validator: (value) => validateName(value!, context),
                                    ),
                                  ),
                                  // Email Text Field...
                                  Container(
                                    margin: EdgeInsets.only(bottom: 21.0.h),
                                    child: CustomTextField(
                                      controller: _emailController,
                                      isPassword: false,
                                      placeholder: "Email",
                                      width: double.infinity,
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      isNumeric: false,
                                      validator: (value) => validateEmail(value!, context),
                                    ),
                                  ),
                                  // Password Text Field...
                                  Container(
                                    margin: EdgeInsets.only(bottom: 21.0.h),
                                    child: CustomTextField(
                                      denySpaces: true,
                                      controller: _passwordController,
                                      isPassword: true,
                                      placeholder: "Password",
                                      width: double.infinity,
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      isNumeric: false,
                                      validator: (value) => validatePasswordForLogin(value!, context),
                                    ),
                                  ),
                                  // Confirm Password Text Field...
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10.0.h),
                                    child: CustomTextField(
                                      denySpaces: true,
                                      controller: _confirmPasswordController,
                                      isPassword: true,
                                      placeholder: "Confirm Password",
                                      width: double.infinity,
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      isNumeric: false,
                                      validator: (value) => validatePasswordForLogin(value!, context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            // Checkbox and text...
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isChecked = !_isChecked;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 5.w),
                                    width: 24.w,
                                    height: 24.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: _isChecked ? const Color(0xFF3629B6) : const Color(0xFFCACACA),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: _isChecked
                                        ? const Icon(
                                      Icons.check,
                                      color: Color(0xFF3629B6),
                                      size: 16,
                                    )
                                        : null,
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'By creating an account you agree \n to our ',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 14.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Terms and Conditions',
                                        style: TextStyle(
                                          color: Color(0xFF3629B6),
                                          fontSize: 14.sp,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          height: 0.08,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Navigate to the terms and conditions page
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 22.h,
                            ),
                            // Sign Up Button...
                            InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  // Call the sign up API
                  
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 50.h,
                                decoration: ShapeDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment(1.00, -0.01),
                                    end: Alignment(-1, 0.01),
                                    colors: [Color(0xFF1474C2), Color(0xFF86C0F2)],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.92.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Center(
                              child: Text(
                                'or sign Up with',
                                style: TextStyle(
                                  color: const Color(0xFF888888),
                                  fontSize: 16.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 86.w,
                                  height: 42.h,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF4F4F4),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/google.svg',
                                    width: 27.w,
                                    height: 27.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: 86.w,
                                  height: 42.h,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF4F4F4),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/facebook.svg',
                                    width: 27.w,
                                    height: 27.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Container(
                                  width: 86.w,
                                  height: 42.h,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFF4F4F4),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/apple.svg',
                                    width: 27.w,
                                    height: 27.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Have an account?',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 12.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignInScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      color: Color(0xFF9BCCF3),
                                      fontSize: 12.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}