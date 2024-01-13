import 'package:apay/constants.dart';
import 'package:apay/user/model/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  DatabaseUser user = DatabaseUser(
      id: "",
      name: "",
      surname: "",
      email: "",
      hashedPassword: "",
      phone: "",
      tckn: "",
      birthday: "",
      serial: "",
      validUntil: "",
      passwordTry: 0,
      type: AppConst.defaultUserType);
  void setUser(DatabaseUser u) {
    user = u;
    notifyListeners();
  }
}
