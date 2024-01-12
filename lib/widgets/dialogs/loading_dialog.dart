import 'package:apay/constants.dart';
import 'package:flutter/material.dart';

class LoadingScreen {
  LoadingScreen._();

  static show(BuildContext context, String text) {
    return showDialog(

        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: _customDialog(context, text),
            ),
          );
        });
  }

  static hide(BuildContext context) {
    Navigator.pop(context);
  }

  static _customDialog(BuildContext context, String text) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: AppConst.backgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                  ,
                    color: Colors.white,),
              ),
              const SizedBox(height: 12,),
              const Text('Bu işlem birkaç saniye sürebilir, lütfen bekle.', textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontFamily: 'poppins', fontWeight: FontWeight.w500),),
              const SizedBox(height: 25,),
              
              const CircularProgressIndicator(
                
                strokeWidth: 7,
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
              
              
            ],
          ),
        ),
      ),
    );
  }
}