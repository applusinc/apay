import 'package:apay/constants.dart';
import 'package:apay/screens/auth/register/provider/register_provider.dart';
import 'package:apay/screens/auth/service/auth_service.dart';
import 'package:apay/widgets/dialogs/loading_dialog.dart';
import 'package:apay/widgets/dialogs/response_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class EmailPage extends StatefulWidget {
  final PageController pageController;
  const EmailPage({super.key, required this.pageController});
  //required this.pageController,
  // required this.onPageChanged,

  //final PageController pageController;
  //final Function(int) onPageChanged;

  @override
  State<EmailPage> createState() => _EmailPage();
}

class _EmailPage extends State<EmailPage> {
  final TextEditingController _emailController = TextEditingController();
  bool emailSended = false;
  bool emailVerified = false;

  bool changed = false;
  @override
  Widget build(BuildContext context) {
    // try {
    //   if (!changed) {
    //     _emailController.text =
    //         Provider.of<RegisterProvider>(context, listen: false).phone;
    //     changed = true;
    //   }
    //   // ignore: empty_catches
    // } catch (e) {}

    void onCodeSent(String verificationID) {
      LoadingScreen.hide(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Kod Gönderildi.')));

      Provider.of<RegisterProvider>(context, listen: false)
          .setVerificationID(verificationID);

      widget.pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn);
    }

    void hideDialog() {
      Navigator.pop(context);
    }

    void showCustomDialog(BuildContext context) {
      String emailAdress =
          Provider.of<RegisterProvider>(context, listen: false).email;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      "assets/images/illustration0.png",
                    ),
                  ),
                  const Text(
                    'Adresi Kontrol Et',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'poppins',
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    emailAdress,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Doğrulama bağlantısı göndereceğiz.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'averta'),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 30,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppConst.primaryColor),
                          onPressed: () async {
                            AuthService().checkEmail(
                              Provider.of<RegisterProvider>(context,
                                  listen: false),
                              onSuccess: (result) async {
                                if (!result) {
                                  hideDialog();
                                  LoadingScreen.show(
                                      context, "Bilgilerin kontrol ediliyor");
                                  bool sended = await AuthService()
                                      .sendEmailVerification(emailAdress);
                                  hideDialog();
                                  if (sended) {
                                    setState(() {
                                      emailSended = true;
                                    });
                                  } else {
                                    mounted
                                        ? ResponseDialog.show(context, "Hata",
                                            "E-mail gönderilemedi.")
                                        : null;
                                    emailSended = false;
                                  }
                                } else {
                                  ResponseDialog.show(context, "Hata",
                                      "Bu email başka bir hesapta kullanılıyor.");
                                  emailSended = false;
                                }
                              },
                              onFail: (errorMsg) {
                                ResponseDialog.show(context, "Hata",
                                    AppConst.internalServerErrorMessage);
                                emailSended = false;
                              },
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Evet",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'jiho',
                                  fontSize: 16),
                            ),
                          ))),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 30,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              side: const BorderSide(
                                  color: AppConst.primaryColor)),
                          onPressed: () => {Navigator.pop(context)},
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Hayır",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'jiho',
                                  fontSize: 16),
                            ),
                          ))),
                ],
              ),
            ),
          );
        },
      );
    }

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
                "Email Adresi",
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
                emailSended
                    ? "Mailinize doğrulama kodu gönderildi."
                    : "E-mail adresinizi yazmalısınız",
                style: const TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Visibility(
                visible: !emailSended,
                child: TextField(
                  controller: _emailController,
                  maxLength: 50,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                  decoration: const InputDecoration(
                    counterText: "",
                    labelText: 'E-mail Adresi',
                    labelStyle: TextStyle(
                      color: Colors.white70,
                      fontSize: 17,
                      fontFamily: 'averta',
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFF837E93),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFF9F7BFF),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(
                        () {}); // Trigger a rebuild to update button opacity
                  },
                ),
              ),
              SizedBox(
                height: emailSended & !emailVerified ? 0 : 0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end, // Add this line
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          await auth.currentUser?.reload();
                          debugPrint(auth.currentUser?.email);

                          bool isVerified =
                              auth.currentUser?.emailVerified ?? false;
                          if (isVerified) {
                            emailVerified = true;
                            // ResponseDialog.show(
                            //     context, "Başarılı", "Doğrulandı.");
                          } else {
                            emailVerified = false;
                            // ResponseDialog.show(
                            //     context, "Başarısız", "Henüz doğrulanmadı.");
                          }
                          debugPrint(isVerified.toString());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConst.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 13),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            Text('Kontrol et',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'poppins'))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'E-mail adresine gönderilen linke tıkla.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ],
                  ),
                ),
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
              backgroundColor:
                  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(_emailController.text)
                      ? AppConst.primaryColor
                      : AppConst.primaryColor.withOpacity(0.5),
            ),
            onPressed: !emailSended
                ? RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(_emailController.text)
                    ? () {
                        Provider.of<RegisterProvider>(context, listen: false)
                            .setEmail(_emailController.text.trim());

                        showCustomDialog(context);
                        // widget.pageController.nextPage(
                        //   duration: Duration(milliseconds: 300),
                        //   curve: Curves.fastOutSlowIn,
                        // );
                        // widget.onPageChanged(widget.pageController.page?.round() ?? 0);
                      }
                    : () => ResponseDialog.show(
                        context, "Hata", "E-mail adresiniz yanlış formatta.")
                : () {
                    widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn);
                  },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                !emailSended ? "Gönder" : "Devam et",
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
    ));
  }
}
