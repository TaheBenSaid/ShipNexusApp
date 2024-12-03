import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:shipnexusapp/core/ui/colors/colors.dart';
import 'package:shipnexusapp/features/auth/presentation/pages/signin_screen.dart';

import '../../../../core/validations/input_validations.dart';
import '../../../../core/widgets/map_input.dart';
import '../../../map_feature/presentation/pages/map_page.dart';
import '../widgets/refactored_intl_phone_field.dart';

class SecondSignUpScreen extends StatefulWidget {
  const SecondSignUpScreen({Key? key}) : super(key: key);

  @override
  State<SecondSignUpScreen> createState() => _SecondSignUpScreenState();
}

class _SecondSignUpScreenState extends State<SecondSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String completePhoneNumber = ''; // New variable for complete phone number
  final TextEditingController locationController = TextEditingController();

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
                        'Sign Up',
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
                                  Center(
                                    child: Image.asset(
                                      'assets/images/app_logo_blue.png',
                                      width: 283.w,
                                      height: 189.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        'continue with creating New account',
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 12.sp,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25.h,
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
                                // Location Text Field...
                                MapInput(
                                  initialLatitude: 0.0,
                                  initialLongitude: 0.0,
                                  updateLocation: (locationName, lat, lng) {
                                    setState(() {
                                      // update the user location...
                                      locationController.text = locationName;

                                    });
                                  },
                                  locationController: locationController,
                                ),
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
                                    completePhoneNumber = phone.completeNumber;
                                    print(
                                        "compleeeete ${phone.countryISOCode}");
                                  },
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
                                      color: _isChecked
                                          ? const Color(0xFF3629B6)
                                          : const Color(0xFFCACACA),
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
                                  text:
                                      'By creating an account you agree \n to our ',
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
