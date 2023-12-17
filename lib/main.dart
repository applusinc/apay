import 'package:apay/constants.dart';
import 'package:apay/widgets/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: AppConst.primaryColor,
          hintColor: AppConst.secondaryColor,
          scaffoldBackgroundColor: AppConst.backgroundColor,
          cardColor: AppConst.surfaceColor,
          appBarTheme: const AppBarTheme(
            color: AppConst.primaryColor,
          ),
          colorScheme: const ColorScheme.dark(
            primary: AppConst.primaryColor,
            onPrimary: AppConst.onPrimaryColor,
            secondary: AppConst.secondaryColor,
            onSecondary: AppConst.onSecondaryColor,
            error: AppConst.errorColor,
            onError: AppConst.onErrorColor,
            background: AppConst.backgroundColor,
            onBackground: AppConst.onBackgroundColor,
            surface: AppConst.surfaceColor,
            onSurface: AppConst.onSurfaceColor,
          )
              .copyWith(background: AppConst.backgroundColor)
              .copyWith(error: AppConst.errorColor)),
      home: const SplashScreen(),
    );
  }
}
