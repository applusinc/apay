import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

// ignore: must_be_immutable
class MenuButton extends StatelessWidget {
  VoidCallback press;
  ValueChanged<Artboard> riveOnInit;
  MenuButton({
    super.key,
    required this.press,
    required this.riveOnInit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(left: 10),
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 3), blurRadius: 8),
            ]),
        child: RiveAnimation.asset(
          "assets/animicons/menu_button.riv",
          onInit: riveOnInit,
        ),
      )),
    );
  }
}