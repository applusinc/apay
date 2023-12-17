// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:apay/constants.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'package:apay/models/hive_assets.dart';

// ignore: must_be_immutable
class SideMenuTile extends StatelessWidget {
  RiveAsset rive;
  VoidCallback press;
  ValueChanged<Artboard> riveonInit;
  bool isActive;
  SideMenuTile({
    Key? key,
    required this.rive,
    required this.press,
    required this.riveonInit,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24.0),
          child: Divider(),
        ),
        Stack(
          children: [
         
                 AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  left: 0,
                  curve: Curves.fastOutSlowIn,
                    height: 56,
                    width: isActive ? 288 : 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AppConst.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    )),
               
            ListTile(
                onTap: press,
                title: Text(rive.title),
                leading: SizedBox(
                  height: 34,
                  width: 34,
                  child: RiveAnimation.asset(
                    rive.src,
                    artboard: rive.artboard,
                    onInit: riveonInit,
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
