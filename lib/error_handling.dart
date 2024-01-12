import 'dart:convert';

import 'package:apay/constants.dart';
import 'package:apay/widgets/dialogs/response_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required void Function(Map<String, dynamic> decodedBody) onSuccess,
  required void Function(Map<String, dynamic> decodedBody, String errorMsg)
      onFail,
}) {
  final Map<String, dynamic> decodedBody = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedBody.containsKey('error')) {
      onFail(decodedBody, AppConst.internalServerErrorMessage);
    } else {
      onSuccess(decodedBody);
    }
  } else if (response.statusCode == 500) {
    onFail(decodedBody, AppConst.internalServerErrorMessage);
  } else {
    onFail(decodedBody, decodedBody["error"]);
  }
}

class HttpDialogs {
  static void internalServerErrorDialog(BuildContext context) {
    ResponseDialog.show(context, "Hata", AppConst.internalServerErrorMessage);
  }

  static void showErrorDialog(BuildContext context, String message) {
    ResponseDialog.show(context, "Hata", message);
  }
}