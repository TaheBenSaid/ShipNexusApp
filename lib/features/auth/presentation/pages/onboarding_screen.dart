import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipnexusapp/core/ui/colors/colors.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/app_logo_white.png",
      "title": "Find transports you trust",
      "description":
          "To connect individuals and businesses with trusted transporters for reliable and efficient cross-country delivery services."
    },
    {
      "image": "assets/images/app_logo_white.",
      "title": "Fast Delivery",
      "description":
          "The dish is artfully created with a velvety balance, elevating a harmonious blend of sweet and savory notes that dance on your palate."
    },
    {
      "image": "assets/images/app_logo_white.",
      "title": "Welcome to DELIVER.TN",
      "description":
          "Elevate your transport experience with this game-changing digital App!"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return OnboardingPage(
                  image: onboardingData[index]["image"]!,
                  title: onboardingData[index]["title"]!,
                  description: onboardingData[index]["description"]!,
                  onboardingData: onboardingData,
                  buildDot: buildDot,
                  currentPage: _currentPage,
                );
              },
            ),
          ),
        ],
      ),
      bottomSheet: _currentPage == onboardingData.length - 1
          ? Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            // Navigate to the next screen
          },
          child: const Text("Get Started!"),
        ),
      )
          : Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                _pageController.jumpToPage(onboardingData.length - 1);
              },
              child: Text(
                "Skip",
                style: TextStyle(
                  color: Color(0xFF686868),
                  fontSize: 15.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: Container(
                child: Icon(Icons.arrow_forward_ios),
                width: 59,
                height: 51,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                  shadows: [
                    BoxShadow(
                      color: Color(0x7FFF6347),
                      blurRadius: 10,
                      offset: Offset(0, 3),
                      spreadRadius: 0,
                    )
                  ],

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      height: _currentPage == index ? 20.w : 10.w,
      width: _currentPage == index ? 20.w : 10.w,
      decoration: BoxDecoration(
        color: _currentPage == index ? Color(0xFF1474C2) : Colors.black,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}


class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final List<Map<String, String>> onboardingData;
  final Widget Function(int, BuildContext) buildDot;
  final int currentPage;

  const OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
    required this.onboardingData,
    required this.buildDot,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(
                  double.infinity, MediaQuery.of(context).size.height * 0.45),
              painter: ArcPainter(),
            ),
            Column(
              children: [
                SizedBox(height: 40.h),
                Row(
                  children: [
                    Transform(
                      transform: Matrix4.identity()
                        ..translate(-30.0, -70.0)
                        ..rotateZ(-3.13),
                      child: Container(
                        width: 80.w,
                        height: 89.h,
                        child: Stack(
                          children: [
                            Transform(
                              transform: Matrix4.identity()
                                ..translate(0.0, 0.0)
                                ..rotateZ(-3.13),
                              child: Container(
                                width: 72.w,
                                height: 72.h,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF161455),
                                  shape: OvalBorder(),
                                ),
                              ),
                            ),
                            Transform(
                              transform: Matrix4.identity()
                                ..translate(-85.0.w, -85.0.h),
                              child: Container(
                                width: 16.w,
                                height: 16.h,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: OvalBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                        width: 300.w,
                        height: 200.h,
                      ),
                    ),
                    Transform(
                      transform: Matrix4.identity()
                        ..translate(50.0, 70.0)
                        ..rotateZ(-3.13),
                      child: Container(
                        width: 80.w,
                        height: 89.h,
                        child: Stack(
                          children: [
                            Transform(
                              transform: Matrix4.identity()
                                ..translate(0.0, 0.0)
                                ..rotateZ(-3.13),
                              child: Container(
                                width: 72.w,
                                height: 72.h,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF161455),
                                  shape: OvalBorder(),
                                ),
                              ),
                            ),
                            Transform(
                              transform: Matrix4.identity()
                                ..translate(0.0.w, 0.0.h),
                              child: Container(
                                width: 16.w,
                                height: 16.h,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: OvalBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 179.h),
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 28.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        Text(
          description,
          style: TextStyle(
            color: Color(0xFF686868),
            fontSize: 16.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30.h),
        Container(
          height: 20.h,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
                  (index) => buildDot(index, context),
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppConstants.primaryColor
      ..style = PaintingStyle.fill;

    final path = Path()
      ..lineTo(0, size.height - 40)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 40)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
