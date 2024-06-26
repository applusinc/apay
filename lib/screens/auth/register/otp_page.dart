import 'package:apay/constants.dart';
import 'package:apay/screens/auth/register/provider/register_provider.dart';
import 'package:apay/screens/auth/service/auth_service.dart';
import 'package:apay/widgets/dialogs/loading_dialog.dart';
import 'package:apay/widgets/otp_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OTPPage extends StatefulWidget {
  final PageController controller;

  const OTPPage({super.key, required this.controller});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  String value = "1";

  void onOTPSuccess() {
    widget.controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    String phoneNumber = "+90${Provider.of<RegisterProvider>(context).phone}";
    return Padding(
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
          Container(
            height: 56,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppConst.primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: OtpForm(
                callBack: (code) {
                  setState(() {
                    value = code;
                  });
                },
              ),
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
                backgroundColor: value.length == 6
                    ? AppConst.primaryColor
                    : AppConst.primaryColor.withOpacity(0.5),
              ),
              onPressed: value.length == 6
                  ? () async {
                      try {
                        String verifID =
                            Provider.of<RegisterProvider>(context, listen: false)
                                .verificationID;
                        LoadingScreen.show(
                            context, 'Bilgileriniz kontrol ediliyor.');
                        AuthService()
                            .verifyOTPForRegister(verifID, value, context, onOTPSuccess);
                      // ignore: empty_catches
                      } catch (e) {}

                      // Navigator.popAndPushNamed(context, '/onboarding');
                    }
                  : null,
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Kayıt ol",
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
    );
  }
}
