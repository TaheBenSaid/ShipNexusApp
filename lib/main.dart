import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipnexusapp/injection.dart';

import 'core/app_theme.dart';
import 'features/auth/presentation/pages/second_signup_screen.dart';
import 'features/auth/presentation/pages/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
         theme: appTheme,
        home: SecondSignUpScreen(),
      ),
    );
  }
}
