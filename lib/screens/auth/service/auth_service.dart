// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:apay/constants.dart';
import 'package:apay/error_handling.dart';
import 'package:apay/models/user.dart';
import 'package:apay/screens/auth/register/provider/register_provider.dart';
import 'package:apay/widgets/dialogs/loading_dialog.dart';
import 'package:apay/widgets/dialogs/response_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  void sendSmsVerification(BuildContext context, Function onSent, String phoneNumber) async {
    final phoneNum =
        "+90$phoneNumber";
    auth.verifyPhoneNumber(
      phoneNumber: phoneNum,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (credential) {},
      verificationFailed: (exception) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(exception.message.toString())));
      },
      codeSent: (verificationId, forceResendingToken) {
        onSent(verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  void verifyOTPForRegister(String verificationId, String smsCode, BuildContext context,
      Function onSuccess) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      // ignore: unused_local_variable
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);   
          

      await AuthService().checkPhone(
        Provider.of<RegisterProvider>(context, listen: false),
        onSuccess: (result) {
          if (!result) {
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Row(
              children: <Widget>[
                // add your preferred icon here
                Icon(
                  Icons.warning_amber,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),

                // add your preferred text content here
                Text("Oturum açma hatası"),
              ],
            ),
          ));
        } else {
          Provider.of<RegisterProvider>(context, listen: false)
              .setID(userCredential.user!.uid);
              onSuccess();
          
        }
      });



            
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Row(
                children: <Widget>[
                  // add your preferred icon here
                  Icon(
                    Icons.warning_amber,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),

                  // add your preferred text content here
                  Text("Bu hesaba ait telefon numarası zaten kayıtlı."),
                ],
              ),
            ));
          }
        },
        onFail: (errorMsg) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Row(
              children: <Widget>[
                // add your preferred icon here
                Icon(
                  Icons.warning_amber,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),

                // add your preferred text content here
                Text(AppConst.internalServerErrorMessage),
              ],
            ),
          ));
        },
      );

      

      LoadingScreen.hide(context);
    } catch (e) {
      debugPrint(e.toString());
      LoadingScreen.hide(context);
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-verification-code') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Row(
              children: <Widget>[
                // add your preferred icon here
                Icon(
                  Icons.warning_amber,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),

                // add your preferred text content here
                Text("Doğrulama kodu yanlış. Lütfen tekrar deneyiniz."),
              ],
            ),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              children: <Widget>[
                // add your preferred icon here
                const Icon(
                  Icons.warning_amber,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 10,
                ),

                // add your preferred text content here
                Text("Oturum açma hatası, ${e.message.toString()}"),
              ],
            ),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            children: <Widget>[
              // add your preferred icon here
              Icon(
                Icons.warning_amber,
                color: Colors.red,
              ),
              SizedBox(
                width: 10,
              ),

              // add your preferred text content here
              Text("Bilinmeyen bir hata oluştu."),
            ],
          ),
        ));
      }
    }
  }




  void verifyOTPForLogin(String verificationId, String smsCode, BuildContext context,
      Function onSuccess) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      // ignore: unused_local_variable
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);   
          
LoadingScreen.hide(context);
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Row(
              children: <Widget>[
                // add your preferred icon here
                Icon(
                  Icons.warning_amber,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),

                // add your preferred text content here
                Text("Oturum açma hatası"),
              ],
            ),
          ));
        } else {
          Provider.of<RegisterProvider>(context, listen: false)
              .setID(userCredential.user!.uid);
              onSuccess();
          
        }
      });
      

      
    } catch (e) {
      debugPrint(e.toString());
      LoadingScreen.hide(context);
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-verification-code') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Row(
              children: <Widget>[
                // add your preferred icon here
                Icon(
                  Icons.warning_amber,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),

                // add your preferred text content here
                Text("Doğrulama kodu yanlış. Lütfen tekrar deneyiniz."),
              ],
            ),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              children: <Widget>[
                // add your preferred icon here
                const Icon(
                  Icons.warning_amber,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 10,
                ),

                // add your preferred text content here
                Text("Oturum açma hatası, ${e.message.toString()}"),
              ],
            ),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            children: <Widget>[
              // add your preferred icon here
              Icon(
                Icons.warning_amber,
                color: Colors.red,
              ),
              SizedBox(
                width: 10,
              ),

              // add your preferred text content here
              Text("Bilinmeyen bir hata oluştu."),
            ],
          ),
        ));
      }
    }
  }














  Future<bool> sendEmailVerification(String email) async {
    if (auth.currentUser?.emailVerified ?? true) {
      return false;
    } else {
      try {
        await auth.currentUser?.verifyBeforeUpdateEmail(email);
        return true;
      } catch (e) {
        debugPrint('hata ${e.toString()}');
        return false;
      }
    }
  }

  Future<bool> checkEmailVerification() async {
    return auth.currentUser?.emailVerified ?? false;
  }

  Future<void> signUpUser(
      RegisterProvider registerProvider, BuildContext context,
      {required void Function(Map<String, dynamic> decodedBody) onSuccess,
      required Function(Map<String, dynamic> decodedBody, String errorMsg)
          onFail}) async {
    try {
      String formattedDate =
          DateFormat('dd.MM.yyyy').format(registerProvider.birthdate);
      DatabaseUser user = DatabaseUser(
        id: registerProvider.id,
        name: registerProvider.name,
        surname: registerProvider.surname,
        email: registerProvider.email,
        hashedPassword: registerProvider.hashedPassword,
        phone: "90${registerProvider.phone}",
        tckn: registerProvider.tckn,
        birthday: formattedDate,
        serial: registerProvider.serialNumber,
        validUntil: registerProvider.validUntil,
        passwordTry: 0,
        token: "a",
        type: AppConst.defaultUserType,
      );
      http.Response res = await http.post(
        Uri.parse(
            '${AppConst.authServerAdress}:${AppConst.authServerPort}/api/signup'),
        body: user.toJson(),
        headers: AppConst.registerHeader,
      );
      debugPrint(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: onSuccess,
        onFail: onFail,
      );
    } catch (e) {
      debugPrint(e.toString());
      if (context.mounted) {
        LoadingScreen.hide(context);
      }
      ResponseDialog.show(context, "Hata", AppConst.internalServerErrorMessage);
    }
  }

  Future<void> checkPhone(RegisterProvider registerProvider,
      {required void Function(bool result) onSuccess,
      required Function(String errorMsg) onFail}) async {
    http.Response res = await http.post(
        Uri.parse(
            '${AppConst.authServerAdress}:${AppConst.authServerPort}/api/checkphone'),
        body: jsonEncode({"phone": "90${registerProvider.phone}"}),
        headers: AppConst.registerHeader);
        debugPrint(res.body);
    Map<String, dynamic> decoded = jsonDecode(res.body);
    if (res.statusCode == 200) {
      if(decoded["result"] == "false"){
        onSuccess(false);
      }else {
        onSuccess(true);

      }
    } else if (res.statusCode == 500) {
      onFail(AppConst.internalServerErrorMessage);
    } else {
      onFail(decoded["error"]);
    }
  }


  Future<void> checkTCKN(RegisterProvider registerProvider,
      {required void Function(bool result) onSuccess,
      required Function(String errorMsg) onFail}) async {
    http.Response res = await http.post(
        Uri.parse(
            '${AppConst.authServerAdress}:${AppConst.authServerPort}/api/checktckn'),
        body: jsonEncode({"tckn": registerProvider.tckn}),
        headers: AppConst.registerHeader);
        debugPrint(res.body);
    Map<String, dynamic> decoded = jsonDecode(res.body);
    if (res.statusCode == 200) {
      if(decoded["result"] == "false"){
        onSuccess(false);
      }else {
        onSuccess(true);

      }
    } else if (res.statusCode == 500) {
      onFail(AppConst.internalServerErrorMessage);
    } else {
      onFail(decoded["error"]);
    }
  }

  Future<void> checkEmail(RegisterProvider registerProvider,
      {required void Function(bool result) onSuccess,
      required Function(String errorMsg) onFail}) async {
    http.Response res = await http.post(
        Uri.parse(
            '${AppConst.authServerAdress}:${AppConst.authServerPort}/api/checkemail'),
        body: jsonEncode({"email": registerProvider.email}),
        headers: AppConst.registerHeader);
        debugPrint(res.body);
    Map<String, dynamic> decoded = jsonDecode(res.body);
    if (res.statusCode == 200) {
      if(decoded["result"] == "false"){
        onSuccess(false);
      }else {
        onSuccess(true);

      }
    } else if (res.statusCode == 500) {
      onFail(AppConst.internalServerErrorMessage);
    } else {
      onFail(decoded["error"]);
    }
  }






}
