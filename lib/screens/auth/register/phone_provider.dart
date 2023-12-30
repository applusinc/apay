import 'package:flutter/material.dart';

class PhoneProvider extends ChangeNotifier {
  late String phone;
  void setPhone(String phn) {
    phone = phn;
    notifyListeners();
  }

  String getPhone() {
    return phone;

  }
}
