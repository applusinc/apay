import 'package:apay/classes/hex_color.dart';
import 'package:apay/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: HexColor(AppConst.backgroundColor),
        statusBarIconBrightness: Brightness.light));

    return Scaffold(
      body: Container(
        color: HexColor(AppConst.backgroundColor),
        child: Center(
            child: Text(
          "apay",
          style: TextStyle(
              fontFamily: 'jiho',
              color: HexColor(AppConst.splashTextColor),
              fontSize: 80,
              fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
