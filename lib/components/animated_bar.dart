import 'package:apay/constants.dart';
import 'package:flutter/material.dart';

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActivate
  });

  final bool isActivate;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.only(bottom: 2),
      height: isActivate ? 4 : 0,
      width: 20,
      decoration: BoxDecoration(
          color: AppConst.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}