import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shipnexusapp/core/ui/colors/colors.dart';

import '../../../../core/ui/custom_text_field.dart';
import '../../../../core/validations/input_validations.dart';

class SignUpScreen extends StatefulWidget {
  final bool isChecked;

  const SignUpScreen({Key? key, required this.isChecked}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
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
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // Email Text Field...
                              Container(
                                margin: EdgeInsets.only(bottom: 21.0.h),
                                child: CustomTextField(
                                  controller: _nameController,
                                  isPassword: false,
                                  placeholder: "Name",
                                  width: 327.w,
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  isNumeric: false,
                                  validator: (value) =>
                                      validateName(value!, context),
                                ),
                              ),

                              // Email Text Field...
                              Container(
                                margin: EdgeInsets.only(bottom: 21.0.h),
                                child: CustomTextField(
                                  controller: _emailController,
                                  isPassword: false,
                                  placeholder: "Email",
                                  width: 327.w,
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  isNumeric: false,
                                  validator: (value) =>
                                      validateEmail(value!, context),
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
                                  width: 327.w,
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  isNumeric: false,
                                  validator: (value) =>
                                      validatePasswordForLogin(value!, context),
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
                                  width: 327.w,
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  isNumeric: false,
                                  validator: (value) =>
                                      validatePasswordForLogin(value!, context),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 20.h,
                        ),

                        // check box and text...
                        // Checkbox and text...
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Toggle the checkbox state
                                  // widget.isChecked = !widget.isChecked;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 5.w),
                                width: 20.w,
                                height: 20.h,
                                decoration: BoxDecoration(
                                  color: widget.isChecked ? const Color(0xFF3629B6) : Colors.white,
                                  border: Border.all(
                                    color: const Color(0xFF3629B6),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: widget.isChecked
                                    ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                )
                                    : null,
                              ),
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
                        Container(
                          alignment: Alignment.center,
                          width: 314.w,
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
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'or sign Up with',
                          style: TextStyle(
                            color: const Color(0xFF888888),
                            fontSize: 16.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
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
                              child:
                                  // svg image...
                                  SvgPicture.asset(
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
                              child:
                                  // svg image...
                                  SvgPicture.asset(
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
                              child:
                                  // svg image...
                                  SvgPicture.asset(
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
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => SignUpScreen(),
                                //   ),
                                // );
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
