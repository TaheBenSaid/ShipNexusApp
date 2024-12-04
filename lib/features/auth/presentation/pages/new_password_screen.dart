import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:shipnexusapp/core/ui/colors/colors.dart';
import 'package:shipnexusapp/features/auth/presentation/pages/signin_screen.dart';

import '../../../../core/validations/input_validations.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/refactored_intl_phone_field.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  String completePhoneNumber = ''; // New variable for complete phone number

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
                                Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 75.h,
                                        ),
                                        Text(
                                          'Forgot password',
                                          style: TextStyle(
                                            color: Color(0xFF333333),
                                            fontSize: 20.sp,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            height: 0.07,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Text(
                                          'Type your phone number ',
                                          style: TextStyle(
                                            color: Color(0xFF979797),
                                            fontSize: 12.sp,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            height: 0.11,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 33.h,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Form...
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  // Phone Number Text Field...
                                  IntlPhoneField(
                                    pickerDialogStyle: PickerDialogStyle(
                                        searchFieldInputDecoration:
                                            InputDecoration(
                                                hintText: 'Search country')),
                                    invalidNumberMessage:
                                        'Please enter mobile number',
                                    invalidNumberLength:
                                        'Please enter valid mobile number',
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (value) =>
                                        validatePhoneNumber(value!, context),
                                    languageCode: "fr",
                                    dropdownTextStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    controller: _phoneNumberController,
                                    decoration: InputDecoration(
                                      counterStyle:
                                          TextStyle(color: Colors.white),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().radius(12)),
                                        borderSide: const BorderSide(
                                          color: Color(0xffF04438),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color(0xFFCACACA),
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      errorStyle: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12.sp,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                      labelText: 'Phone number',
                                      labelStyle: TextStyle(
                                        color: Color(0xFFCACACA),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFCACACA),
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color(0xFFCACACA),
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    initialCountryCode: 'FR',
                                    onCountryChanged: (phone) {
                                      // Clear the phone number field when the country changes
                                      _phoneNumberController.text = '';
                                    },
                                    onChanged: (phone) {
                                      // Store the complete phone number
                                      completePhoneNumber =
                                          phone.completeNumber;
                                      print(
                                          "compleeeete ${phone.countryISOCode}");
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 20.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'We texted you a code to verify your ',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 14.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 0.11,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                    'phone number',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 14.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 0.11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
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
                                    colors: [
                                      Color(0xFF1474C2),
                                      Color(0xFF86C0F2)
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  'Send',
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
