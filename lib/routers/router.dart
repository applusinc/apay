import 'package:apay/screens/auth/auth_page.dart';
import 'package:apay/screens/auth/register/register_page.dart';
import 'package:apay/screens/onboarding/onboarding_page.dart';
import 'package:apay/screens/page_404.dart';
import 'package:apay/screens/splash_page.dart';
import 'package:apay/screens/mainmenu/main_menu.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case mainMenuRoute:
        return MaterialPageRoute(builder: (_) => const MainMenu());

      case authRoute:
        return MaterialPageRoute(builder: (_) => const AuthPage());

      case onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingPage());

      case registerPage:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Page404(),
        );
    }
  }
}

const String mainRoute = '/';
const String authRoute = '/auth';
const String mainMenuRoute = '/mainmenu';
const String onBoardingRoute = '/onboarding';
const String registerPage = '/register';
