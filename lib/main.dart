import 'package:flutter/material.dart';
import 'package:learnio/app_screens/login/login.dart';

import 'app_screens/onboarding_Screens/onboarding_screen.dart';
import 'app_screens/sign_up/signup.dart';
import 'app_screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),

      },
    );
  }
}
