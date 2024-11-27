import 'package:flutter/material.dart';
import 'onboarding_screen.dart'; // Make sure to import the onboarding screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _logoVisible = false;

  @override
  void initState() {
    super.initState();

    // Delay the animation for a few seconds before fading in the logo
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _logoVisible = true;
      });

      // Delay before fading out the logo
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _logoVisible = false;
        });

        // Delay before navigating to the onboarding screen
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => OnboardingScreen()),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _logoVisible ? 1.0 : 0.0,
              child: Image.asset('assets/images/splash.png', fit: BoxFit.fill),
            ),
          ],
        ),
      ),
    );
  }
}