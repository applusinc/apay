import 'package:apay/constants.dart';
import 'package:apay/widgets/dialogs/loading_dialog.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _RegisAuthPage();
}

class _RegisAuthPage extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Image.asset(
            "assets/images/illustration3.png",
            height: 350,
            width: MediaQuery.of(context).size.width,
          ),
          const Text(
            "Apay Hesabını Oluştur",
            style: TextStyle(
                fontFamily: "poppins",
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Apay, yeni nesil kolay ve pratik cüzdanındır.",
            style: TextStyle(fontFamily: "averta", color: Colors.white60),
          ),
          const Spacer(),
          SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppConst.primaryColor),
                  onPressed: () {
                    LoadingScreen.show(context, "Bilgilerin kontrol ediliyor.");
                    Future.delayed(
                      const Duration(seconds: 2),
                      () {
                        LoadingScreen.hide(context);
                          Navigator.pushNamed(context, '/register');
                      },
                    );

                  
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Kayıt ol",
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
                      side: const BorderSide(color: AppConst.primaryColor)),
                  onPressed: ()  {
                       LoadingScreen.show(context, "Bilgilerin kontrol ediliyor.");
                    Future.delayed(
                      const Duration(seconds: 2),
                      () {
                        LoadingScreen.hide(context);
                          Navigator.pushNamed(context, '/login');
                      },
                    );
                      },
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Giriş yap",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'jiho',
                          fontSize: 16),
                    ),
                  ))),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(children: <InlineSpan>[
                  TextSpan(
                    text: 'Devam ederek ',
                    style: TextStyle(
                        fontFamily: 'averta',
                        fontSize: 12,
                        color: Colors.white60),
                  ),
                  TextSpan(
                    text: 'Kullanıcı Sözleşmesi',
                    style: TextStyle(
                        fontFamily: 'averta',
                        fontSize: 12,
                        color: Colors.white),
                  ),
                  TextSpan(
                    text: ' ve ',
                    style: TextStyle(
                        fontFamily: 'averta',
                        fontSize: 12,
                        color: Colors.white60),
                  ),
                  TextSpan(
                    text: 'Gizlilik Politikası',
                    style: TextStyle(
                        fontFamily: 'averta',
                        fontSize: 12,
                        color: Colors.white),
                  ),
                  TextSpan(
                    text: '\'nı kabul etmiş olursunuz.',
                    style: TextStyle(
                        fontFamily: 'averta',
                        fontSize: 12,
                        color: Colors.white60),
                  )
                ])),
          )
        ],
      )),
    );
  }
}
