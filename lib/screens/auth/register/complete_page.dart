import 'package:apay/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CompletePage extends StatefulWidget {
  final PageController controller;
  const CompletePage({super.key, required this.controller});

  @override
  State<CompletePage> createState() => _CompletePageState();
}

class _CompletePageState extends State<CompletePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Lottie.asset('assets/animations/success.json', repeat: false),
            const Text(
              'Eveeeet!\n Apay\'e Hoşgeldiniz.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('Bize katıldığınız için çok mutluyuz.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontFamily: 'poppins',
                  fontSize: 15,
                )),
            const Spacer(),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppConst.primaryColor,
                      padding: const EdgeInsets.all(17)),
                  child: const Text('Bilgilerinle giriş yap',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: 'jiho')),
                )
              ],
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
