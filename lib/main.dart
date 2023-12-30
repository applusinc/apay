import 'package:apay/constants.dart';
import 'package:apay/screens/auth/register/phone_provider.dart';
import 'package:apay/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apay/routers/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => PhoneProvider())],
      child: MaterialApp(
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
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
      ),
    );
  }
}
