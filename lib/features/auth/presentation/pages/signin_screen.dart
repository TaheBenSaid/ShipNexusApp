import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipnexusapp/core/ui/colors/colors.dart';

import '../../../../core/ui/custom_text_field.dart';
import '../../../../core/validations/input_validations.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: AppConstants.primaryColor,
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 65.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Image.asset(
                    'assets/images/app_logo_blue.png',
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 70.w),
                    child: Column(
                      children: [
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            color: Color(0xFF9BCCF3),
                            fontSize: 24.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Hello there, sign in to continue',
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 12.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 43.h,
                  ),

                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email Text Field...
                          Container(
                            margin: EdgeInsets.only(bottom: 21.0.h),
                            child: CustomTextField(
                              // denySpaces: true,
                              controller: _emailController,
                              isPassword: false,
                              // Set to false for a normal text field
                              placeholder:
                              "Name input",
                              width: 303.w,
                              // Adjust the width as needed
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w400,
                              ),
                              isNumeric: false,
                              validator: (value) =>
                                  validateEmailOrUsername(
                                      value!, context),
                            ),
                          ),

                          // Password Text Field...
                          Container(
                            margin: EdgeInsets.only(bottom: 10.0.h),
                            child: CustomTextField(
                              denySpaces: true,
                              controller: _passwordController,
                              isPassword: true,
                              // Set to true for a password field
                              placeholder: "Password",
                              width: 303.w,
                              // Adjust the width as needed
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w400,
                              ),
                              isNumeric: false,
                              validator: (value) =>
                                  validatePasswordForLogin(
                                      value!, context),
                            ),
                          ),
                        ],
                      )),

                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
