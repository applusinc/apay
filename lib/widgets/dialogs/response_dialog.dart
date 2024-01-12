import 'package:apay/constants.dart';
import 'package:flutter/material.dart';

class ResponseDialog {
  ResponseDialog._();

  void showResponseDialog(BuildContext context, String label, String text) {
    show(context, label, text);
    return;
  }

  static show(BuildContext context, String label, String text) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: _customDialog(context, label, text),
          );
        });
  }

  static _customDialog(BuildContext context, String label, String text) {
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
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white70,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppConst.primaryColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Tamam",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'jiho',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
