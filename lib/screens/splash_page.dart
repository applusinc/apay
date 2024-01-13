import 'package:apay/classes/hex_color.dart';
import 'package:apay/constants.dart';
import 'package:apay/user/provider/user_provider.dart';
import 'package:apay/user/service/user_service.dart';
import 'package:apay/widgets/dialogs/response_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacityValue = 0.0;
  void ready(bool isLogged) {
    Future.delayed(const Duration(seconds: 4), () {
      if (isLogged) {
        Navigator.pushNamedAndRemoveUntil(
            context, "/reloginpin", (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, "/auth", (route) => false);
      }
    });
  }

  Future<void> setup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    String token = await prefs.getString("x-auth-token") ?? "";
    await UserService().getUser(token, (statusCode) {
      if (statusCode == 401) {
        ready(false);
      } else if (statusCode == 500) {
        ResponseDialog.show(
            context, "Hata", AppConst.internalServerErrorMessage);
      } else if (statusCode == 408) {
        ready(true);
      } else {
        ResponseDialog.show(context, "Hata", AppConst.unknownErrorMessage);
      }
    }, (user) {
      Provider.of<UserProvider>(context, listen: false).setUser(user);
      ready(true);
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: AppConst.splashAnimDuration), () {
      setState(() {
        opacityValue = 1.0;
      });
    });
    setup();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppConst.backgroundColor,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: Container(
        color: AppConst.backgroundColor,
        child: Center(
          child: AnimatedOpacity(
            opacity: opacityValue,
            duration: Duration(milliseconds: AppConst.splashAnimDuration),
            child: Text(
              "apay",
              style: TextStyle(
                fontFamily: 'jiho',
                color: HexColor(AppConst.splashTextColor),
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
