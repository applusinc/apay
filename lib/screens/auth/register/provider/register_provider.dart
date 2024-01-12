import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  late String id;
  late String phone;
  late String verificationID;
  late String smsCode;
  late String tckn;
  late String name;
  late String surname;
  late DateTime birthdate;
  late String serialNumber;
  late String validUntil;
  late String email;
  late String hashedPassword;
  late int passwordTry;
  late String token;
  late int type;

  void setID(String i) {
    id = i;
    notifyListeners();
  }

  void setType(int t) {
    type = t;
    notifyListeners();
  }

  void setPhone(String phn) {
    phone = phn;
    notifyListeners();
  }

  void setVerificationID(String id) {
    verificationID = id;
    notifyListeners();
  }

  void setSmsCode(String code) {
    smsCode = code;
    notifyListeners();
  }

  void setTckn(String tc) {
    tckn = tc;
    notifyListeners();
  }

  void setName(String n) {
    name = n;
    notifyListeners();
  }

  void setSurname(String s) {
    surname = s;
    notifyListeners();
  }

  void setBirthdate(DateTime b) {
    birthdate = b;
    debugPrint('birthday updated $b');

    notifyListeners();
  }

  void setSerialnumber(String n) {
    serialNumber = n;
    notifyListeners();
  }

  void setValidUntil(String v) {
    validUntil = v;
    notifyListeners();
  }

  void setEmail(String e) {
    email = e;
    notifyListeners();
  }

  void setHashedPassword(String h) {
    hashedPassword = h;
    notifyListeners();
  }

  void setPasswordTry(int t) {
    passwordTry = t;
    notifyListeners();
  }

  void setToken(String t) {
    token = t;
    notifyListeners();
  }
}
