import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  late String id;
  late String phone;
  late String password;
  late String smsCode;
  late String email;
  late int passwordTry;
  late String verificationID;

  void setVerificationID(String i) {
    verificationID = i;
    notifyListeners();
  }

  void setID(String i) {
    id = i;
    notifyListeners();
  }

  void setPhone(String p) {
    phone = p;
    notifyListeners();
  }

  void setPassword(String i) {
    password = i;
    notifyListeners();
  }

  void setSmsCode(String i) {
    smsCode = i;
    notifyListeners();
  }

  void setEmail(String i) {
    email = i;
    notifyListeners();
  }

  void setPasswordTry(int i) {
    passwordTry = i;
    notifyListeners();
  }
}
