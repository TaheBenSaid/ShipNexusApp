import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:shipnexusapp/core/ui/colors/colors.dart';
import 'package:shipnexusapp/features/auth/presentation/pages/signin_screen.dart';

import '../../../../core/ui/custom_text_field.dart';
import '../../../../core/validations/input_validations.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/refactored_intl_phone_field.dart';

class ConfirmationCodeScreen extends StatefulWidget {
  const ConfirmationCodeScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmationCodeScreen> createState() => _ConfirmationCodeScreenState();
}

class _ConfirmationCodeScreenState extends State<ConfirmationCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _confirmationCodeController =
      TextEditingController();

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
                  text: 'Forgot Password',
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 78.h,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 54.w,
                                  height: 302.h,
                                  padding: EdgeInsets.all(16),
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x113629B7),
                                        blurRadius: 30,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Type a code',
                                        style: TextStyle(
                                          color: Color(0xFF979797),
                                          fontSize: 12.sp,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      // Confirmation Code Form...
                                      Form(
                                        key: _formKey,
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          height: 55.h,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: CustomTextField(
                                                      controller:
                                                          _confirmationCodeController,
                                                      isPassword: false,
                                                      placeholder:
                                                          "Confirmation Code",
                                                      width: 183.w,
                                                      textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.sp,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      isNumeric: true,
                                                      validator: (value) =>
                                                          validateConfirmationCode(
                                                              value!, context),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    width: 12.w,
                                                  ),
                                                  // Resend Code Button...
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 100.w,
                                                    height: 50.h,
                                                    decoration: ShapeDecoration(
                                                      color: Color(0xFF3629B6),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Resend',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.sp,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      SizedBox(
                                        width: 295.w,
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    'We texted you a code to verify your phone number',
                                                style: TextStyle(
                                                  color: Color(0xFFC2C1CC),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' (+84) 332249402',
                                                style: TextStyle(
                                                  color: Color(0xFF3629B7),
                                                  fontSize: 14.sp,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        width: 295.h,
                                        child: Text(
                                          'This code will expired 10 minutes after this message. If you don'
                                          't get a message.',
                                          style: TextStyle(
                                            color: Color(0xFF898989),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      // Sign Up Button...
                                      InkWell(
                                        onTap: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // Call the API to send the confirmation code...
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
                                              colors: [
                                                Color(0xFF1474C2),
                                                Color(0xFF86C0F2)
                                              ],
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          child: Text(
                                            'Change password',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.92.sp,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                                  'Have an account? ',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 12.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 0.11,
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
