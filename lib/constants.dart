import 'package:apay/screens/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';

class AppConst {
  static const String internalServerErrorMessage =
      "Bizden kaynaklı bir sorun oluştu. Birkaç dakika sonra tekrar deneyebilirsin.";
      static const String authErrorMessage =
      "Kimliğiniz doğrulanamadı. Tekrar giriş yapmayı deneyin.";
       static const String unknownErrorMessage =
      "Bilinmeyen bir hata oluştu.";
  static const Map<String, String> registerHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  static const String serverAddress = "http://192.168.1.6";
  static const int serverPort = 3000;
  static const int defaultUserType = 2;
  static final List<OnBoard> onBoardList = [
    OnBoard(
        title: "Kolay Yükle, Güvenle Kullan",
        description: "3D Secure ile güvenle para yükle harca",
        image: "assets/images/illustration0.png"),
    OnBoard(
        title: "Dünya Çapında Özgürlük",
        description: "Senin paran, senin cüzdanın",
        image: "assets/images/illustration1.png"),
    OnBoard(
        title: "İhtiyacın olan herşey",
        description: "İster kendine al ister hediye et arkadaşlarını mutlu et",
        image: "assets/images/illustration2.png")
  ];

  static String splashTextColor = "FFFFFF";
  static int splashAnimDuration = 500;

  static Color transFilterItemTextEnable = Colors.grey.shade100;
  static Color itemColor = Colors.grey.shade900;
  static Color avatarBackground = Colors.white24;
  static Color avatar = Colors.white;

  static const Color transFilterItemTextDisable = Colors.white;
  static const Color bottomLayoutColor = Colors.black54;
  static const Color primaryColor = Color(0xFF6200EA); // Primary color
  static const Color onPrimaryColor =
      Colors.white; // Text and icons on primary color

  static const Color secondaryColor = Color(0xFF03DAC6); // Secondary color
  static const Color onSecondaryColor =
      Colors.black; // Text and icons on secondary color

  static const Color errorColor = Colors.red; // Error color
  static const Color onErrorColor =
      Colors.white; // Text and icons on error color

  static const Color backgroundColor = Color(0xFF121212); // Background color
  static const Color onBackgroundColor =
      Colors.white; // Text and icons on background color

  static const Color surfaceColor =
      Color(0xFF1E1E1E); // Surface color (cards, dialogs, etc.)
  static const Color onSurfaceColor = Colors.white;
}
