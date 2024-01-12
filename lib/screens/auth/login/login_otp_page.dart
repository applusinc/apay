import 'package:apay/constants.dart';
import 'package:apay/screens/auth/login/provider/login_provider.dart';
import 'package:apay/screens/auth/service/auth_service.dart';
import 'package:apay/widgets/dialogs/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class LoginOtpPage extends StatefulWidget {
  const LoginOtpPage({super.key});

  @override
  State<LoginOtpPage> createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends State<LoginOtpPage> {
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

  void onSuccess() {
    Navigator.pushReplacementNamed(context, "/loginpin");
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
    String phoneNumber = "+90${Provider.of<LoginProvider>(context).phone}";
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Numaranı doğrula",
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "$phoneNumber 'ya kod gönderdik",
                style: const TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                  if (value2.length > 0 && value2.length < 6) {
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
                                      margin: const EdgeInsets.only(bottom: 9),
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
                ),
              ),
              const SizedBox(
                height: 32,
              ),
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
                  onPressed: pinController.text.length == 6
                      ? () async {
                          focusNode.unfocus();
                          if (formKey.currentState!.validate()) {
                            String verifID = Provider.of<LoginProvider>(context,
                                    listen: false)
                                .verificationID;
                            LoadingScreen.show(
                                context, "Bilgileriniz kontrol ediliyor.");
                            AuthService().verifyOTPForLogin(verifID,
                                pinController.text, context, onSuccess);
                          }
                        }
                      : () {},
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Devam et",
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
      ),
    );
  }
}
