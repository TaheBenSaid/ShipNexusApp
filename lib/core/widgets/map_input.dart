

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../features/map_feature/presentation/pages/map_page.dart';
import '../validations/input_validations.dart';

class MapInput extends StatefulWidget {
  final Function(String, double, double) updateLocation;
  final TextEditingController stadiumController;
  double? initialLatitude;
  double? initialLongitude;

  MapInput({
    Key? key,
    required this.updateLocation,
    required this.stadiumController,
    this.initialLatitude,
    this.initialLongitude
  }) : super(key: key);

  @override
  _MapInputState createState() => _MapInputState();
}

class _MapInputState extends State<MapInput> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool validate() {
    final isValid = _formKey.currentState!.validate();
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    print('map input::: ${widget.initialLatitude}');
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => MapPage(
                  initialLatitude: widget.initialLatitude?.toDouble() ?? 0.0,
                  initialLongitude: widget.initialLongitude?.toDouble() ?? 0.0,
                  isSearch: true, updateLocation: widget.updateLocation)),
        );
      },
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.stadiumController,
        readOnly: true,
        style: TextStyle(
          fontSize: 14.sp,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtil().radius(12)),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtil().radius(12)),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtil().radius(12)),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          isDense: true,
          errorMaxLines: 1,
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 12.sp,
            fontFamily: 'Outfit',
            fontWeight: FontWeight.w400,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtil().radius(12)),
            borderSide: const BorderSide(
              color: Color(0xffF04438),
            ),
          ),
          contentPadding:
          EdgeInsets.symmetric(vertical: 16.h, horizontal: 11.w),
          hintText: 'Match Stadium',
          hintStyle: TextStyle(
            color:
            Color(0xFF7D8485),
            fontSize: 14.sp,
            fontFamily: 'Outfit',
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: const Color(0x0C212C2D),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(12)),
              borderSide:
              // widget.isRegister
              //     ?
              BorderSide(
                color: Colors.white,
              )
            // : BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/map_location.svg',
              width: 30.h,
              height: 30.h,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => MapPage(
                        isSearch: true, initialLatitude: widget.initialLatitude,
                        initialLongitude: widget.initialLongitude, updateLocation: widget.updateLocation)),
              );
            },
            color: Colors.black,
          ),
        ),
        onTap: () {},
        validator: (value) =>
            validateEmptyField(value!, 'Location', context),
      ),
    );
  }
}