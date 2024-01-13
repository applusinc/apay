// ignore_for_file: use_build_context_synchronously, await_only_futures

import 'package:apay/constants.dart';
import 'package:apay/screens/auth/login/provider/login_provider.dart';
import 'package:apay/screens/auth/service/auth_service.dart';
import 'package:apay/user/model/user.dart';
import 'package:apay/user/provider/user_provider.dart';
import 'package:apay/widgets/dialogs/loading_dialog.dart';
import 'package:apay/widgets/dialogs/response_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';

class ReloginPinPage extends StatefulWidget {
  const ReloginPinPage({super.key});

  @override
  State<ReloginPinPage> createState() => _ReloginPinPageState();
}

class _ReloginPinPageState extends State<ReloginPinPage> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  late LoginProvider loginProvider;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    startLocalAuth();
    super.initState();
  }

  void startLocalAuth() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBioAvailable = await localAuthentication.canCheckBiometrics;
    if (isBioAvailable) {
      bool isAuthed = await localAuthentication.authenticate(
          localizedReason: "Apay için giriş yap");
      if (isAuthed) {
        loginProvider = Provider.of<LoginProvider>(context, listen: false);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String phone = await prefs.getString("phone") ?? "";
        String password = await prefs.getString("password") ?? "";
        loginProvider.setPhone(phone);
        loginProvider.setPassword(password);
        LoadingScreen.show(context, "Bilgileriniz kontrol ediliyor.");
        await AuthService().signInUser(
          Provider.of<LoginProvider>(context, listen: false),
          context,
          onSuccess: (decodedBody) async {
            LoadingScreen.hide(context);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false)
                .setUser(DatabaseUser.fromMap(decodedBody["user"]));
            await prefs.setString("x-auth-token", decodedBody["token"]);
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/mainmenu",
              (route) => false,
            );
          },
          onFail: (decodedBody, errorMsg) {
            LoadingScreen.hide(context);
            ResponseDialog.show(context, "Hata", errorMsg);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppConst.primaryColor;
    const fillColor = Colors.transparent;
    Color borderColor = AppConst.primaryColor.withOpacity(0.6);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.white70,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Pin Giriniz",
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("x-auth-token", "");
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/", (route) => false);
                        },
                        child: const Row(
                          children: [
                            Text("Beni unut",
                                style: TextStyle(
                                  fontFamily: 'averta',
                                  fontSize: 16,
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.logout)
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Daha önce oluşturduğunuz 6 haneli pini giriniz.",
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        autovalidateMode: AutovalidateMode.disabled,
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Directionality(
                                textDirection: TextDirection.ltr,
                                child: Pinput(
                                  length: 6,
                                  controller: pinController,
                                  focusNode: focusNode,
                                  listenForMultipleSmsOnAndroid: false,
                                  defaultPinTheme: defaultPinTheme,
                                  separatorBuilder: (index) => const SizedBox(
                                    width: 10,
                                  ),
                                  validator: (value) {
                                    String value2 = value ?? "";
                                    // ignore: prefer_is_empty
                                    if (value2.length > 0 &&
                                        value2.length < 6) {
                                      return "Geçersiz giriş.";
                                    } else {
                                      return null;
                                    }
                                  },
                                  hapticFeedbackType:
                                      HapticFeedbackType.lightImpact,
                                  onCompleted: (value) {
                                    debugPrint('completed $value');
                                  },
                                  onChanged: (value) {
                                    debugPrint('changed $value');
                                    setState(() {});
                                  },
                                  cursor: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 9),
                                        width: 22,
                                        height: 1,
                                        color: focusedBorderColor,
                                      )
                                    ],
                                  ),
                                  focusedPinTheme: defaultPinTheme.copyWith(
                                    decoration:
                                        defaultPinTheme.decoration!.copyWith(
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: focusedBorderColor),
                                    ),
                                  ),
                                  submittedPinTheme: defaultPinTheme.copyWith(
                                    decoration:
                                        defaultPinTheme.decoration!.copyWith(
                                      color: fillColor,
                                      borderRadius: BorderRadius.circular(19),
                                      border:
                                          Border.all(color: focusedBorderColor),
                                    ),
                                  ),
                                  errorPinTheme: defaultPinTheme.copyBorderWith(
                                    border: Border.all(color: Colors.redAccent),
                                  ),
                                ))
                          ],
                        )),
                  )
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: pinController.text.length == 6
                      ? AppConst.primaryColor
                      : AppConst.primaryColor.withOpacity(0.5),
                ),
                onPressed: formKey.currentState?.validate() ?? false
                    ? () async {
                        focusNode.unfocus();
                        if (formKey.currentState!.validate()) {
                          loginProvider = Provider.of<LoginProvider>(context,
                              listen: false);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String phone = await prefs.getString("phone") ?? "";
                          loginProvider.setPhone(phone);
                          loginProvider.setPassword(pinController.text);
                          LoadingScreen.show(
                              context, "Bilgileriniz kontrol ediliyor.");
                          await AuthService().signInUser(
                            Provider.of<LoginProvider>(context, listen: false),
                            context,
                            onSuccess: (decodedBody) async {
                              LoadingScreen.hide(context);
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              Provider.of<UserProvider>(context, listen: false)
                                  .setUser(DatabaseUser.fromMap(
                                      decodedBody["user"]));
                              await prefs.setString(
                                  "x-auth-token", decodedBody["token"]);
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                "/mainmenu",
                                (route) => false,
                              );
                            },
                            onFail: (decodedBody, errorMsg) {
                              LoadingScreen.hide(context);
                              ResponseDialog.show(context, "Hata", errorMsg);
                            },
                          );
                        }
                      }
                    : null,
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Giriş yap",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'jiho',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
