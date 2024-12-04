import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipnexusapp/core/ui/colors/colors.dart';
import 'package:shipnexusapp/features/auth/presentation/pages/signin_screen.dart';

import '../../../../core/ui/custom_text_field.dart';
import '../../../../core/validations/input_validations.dart';
import '../widgets/custom_back_button.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
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
                                  height: 56.h,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 54.w,
                                  height: 316.h,
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
                                      // New Password Field...
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Type your new password',
                                              style: TextStyle(
                                                color: Color(0xFF979797),
                                                fontSize: 12.sp,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            // Password Text Field...
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 21.0.h),
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
                                                validator: (value) =>
                                                    validatePasswordForLogin(
                                                        value!, context),
                                              ),
                                            ),
                                            Text(
                                              'Confirm password',
                                              style: TextStyle(
                                                color: Color(0xFF979797),
                                                fontSize: 12.sp,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            // Confirm Password Text Field...
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 10.0.h),
                                              child: CustomTextField(
                                                denySpaces: true,
                                                controller:
                                                    _confirmPasswordController,
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
                                                validator: (value) =>
                                                    validatePasswordForLogin(
                                                        value!, context),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 33.h,
                                            ),

                                            // Sign Up Button...
                                            InkWell(
                                              onTap: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  // Call the API to send the confirmation code...
                                                  // navigater to sign up screen withouth the back button...
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignInScreen(),
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: double.infinity,
                                                height: 50.h,
                                                decoration: ShapeDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                    begin:
                                                        Alignment(1.00, -0.01),
                                                    end: Alignment(-1, 0.01),
                                                    colors: [
                                                      Color(0xFF1474C2),
                                                      Color(0xFF86C0F2)
                                                    ],
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
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
