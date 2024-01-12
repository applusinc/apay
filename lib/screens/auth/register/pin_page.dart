import 'package:apay/constants.dart';
import 'package:apay/screens/auth/register/provider/register_provider.dart';
import 'package:apay/screens/auth/service/auth_service.dart';
import 'package:apay/widgets/dialogs/loading_dialog.dart';
import 'package:apay/widgets/dialogs/response_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class PinPage extends StatefulWidget {
  final PageController controller;
  const PinPage({super.key, required this.controller});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  late String firstValue;
  late String secondValue;
  bool step = false;
  late RegisterProvider registerProvider;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
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

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pin Oluştur",
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
                  step ? "Pini doğrulayın." : "6 haneli bir pin oluşturun.",
                  style: const TextStyle(
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
                                  String value2 = value ?? '0';
                                  if (step) {
                                    if (value2.length == 6) {
                                      return firstValue == value2
                                          ? null
                                          : 'Pinler eşleşmiyor.';
                                    } else {
                                      return '';
                                    }
                                  } else {
                                    return value2.length == 6 ? null : '';
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
                backgroundColor: formKey.currentState?.validate() ?? false
                    ? AppConst.primaryColor
                    : AppConst.primaryColor.withOpacity(0.5),
              ),
              onPressed: formKey.currentState?.validate() ?? false
                  ? () async {
                      focusNode.unfocus();
                      if (formKey.currentState!.validate()) {
                        if (step) {
                          Provider.of<RegisterProvider>(context,
                                    listen: false)
                                .setHashedPassword(pinController.text);

                          LoadingScreen.show(
                        context, "Bilgileriniz kontrol ediliyor.");
                    registerProvider =
                        Provider.of<RegisterProvider>(context, listen: false);
                    await AuthService().signUpUser(
                      registerProvider,
                      context,
                      onSuccess: (decodedBody) {
                        if (mounted) {
                          LoadingScreen.hide(context);
                        }
                        widget.controller.nextPage(
                               duration: const Duration(milliseconds: 300),
                               curve: Curves.fastOutSlowIn);
                        
                      },
                      onFail: (decodedBody, errorMsg) {
                        if (mounted) {
                          LoadingScreen.hide(context);
                        }
                        ResponseDialog.show(context, "Hata", errorMsg);
                      },
                    );






                           
                        } else {
                          step = true;
                          firstValue = pinController.text;
                          pinController.clear();
                        }
                      }
                    }
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  step ? "Oluştur" : "Doğrula",
                  style: const TextStyle(
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
