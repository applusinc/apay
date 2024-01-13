import 'dart:convert';

import 'package:apay/constants.dart';
import 'package:apay/user/model/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<void> getUser(String token, void Function(int statusCode) onFail,
      void Function(DatabaseUser user) onSuccess) async {
    final res = await http.get(
        Uri.parse(
            '${AppConst.serverAddress}:${AppConst.serverPort}/user'),
        headers: {"x-auth-token": token});
    if (res.statusCode == 200) {
      onSuccess(DatabaseUser.fromMap(jsonDecode(res.body)["user"]));
    } else {
      onFail(res.statusCode);
    }
  }
}
