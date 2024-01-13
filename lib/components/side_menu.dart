// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_import, unused_import
import 'package:apay/classes/rive_utils.dart';
import 'package:apay/models/hive_assets.dart';
import 'package:apay/widgets/card_info.dart';
import 'package:apay/widgets/side_menu_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:apay/classes/hex_color.dart';
import 'package:apay/constants.dart';
import 'package:rive/rive.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 288,
      height: double.infinity,
      color: AppConst.itemColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardInfo(
              name: "Ali Abdullah",
              userID: "118212345",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 32, bottom: 16),
              child: Text(
                "İşlemler".toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white70),
              ),
            ),
            ...sideMenus.map((menu) => SideMenuTile(
                rive: menu,
                press: () {
                  menu.input!.change(true);
                  setState(() {
                    selectedMenu = menu;
                  });
                  Future.delayed(const Duration(seconds: 1), () {
                    menu.input!.change(false);
                  });
                },
                riveonInit: (artboard) {
                  StateMachineController controller =
                      RiveUtils.getRiveController(artboard,
                          stateMachineName: menu.stateMachineName);
                  menu.setInput = controller.findSMI("active") as SMIBool;
                },
                isActive: selectedMenu == menu)),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 32, bottom: 16),
              child: Text(
                "Dİğer".toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white70),
              ),
            ),
            ...sideMenus2.map((menu) => SideMenuTile(
                rive: menu,
                press: () {
                  menu.input!.change(true);
                  setState(() {
                    selectedMenu = menu;
                  });
                  Future.delayed(const Duration(seconds: 1), () {
                    menu.input!.change(false);
                  });
                },
                riveonInit: (artboard) {
                  StateMachineController controller =
                      RiveUtils.getRiveController(artboard,
                          stateMachineName: menu.stateMachineName);
                  menu.setInput = controller.findSMI("active") as SMIBool;
                },
                isActive: selectedMenu == menu)),
          ],
        ),
      ),
    ));
  }
}
