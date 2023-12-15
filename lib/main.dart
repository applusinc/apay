import 'package:apay/constants.dart';
import 'package:apay/widgets/main_menu.dart';
import 'package:apay/widgets/splash_page.dart';
import 'package:flutter/material.dart';
import 'classes/hex_color.dart';

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
          primaryColor: HexColor(AppConst.primaryColor),
          scaffoldBackgroundColor: HexColor(AppConst.backgroundColor)),
      home: SplashScreen(),
    );
  }
}
