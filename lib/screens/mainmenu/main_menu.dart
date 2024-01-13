// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:apay/components/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'package:apay/classes/rive_utils.dart';
import 'package:apay/components/animated_bar.dart';
import 'package:apay/constants.dart';
import 'package:apay/models/hive_assets.dart';
import 'package:apay/screens/mainmenu/home_page.dart';

import '../../widgets/menu_button.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu>
    with SingleTickerProviderStateMixin {
  RiveAsset selectedItem = bottomNavs.first;
  late SMIBool menuIsClosed;
  bool isSideMenuClosed = true;
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> animationScal;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200))
          ..addListener(() {
            setState(() {});
          });

    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));

        
    animationScal = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConst.itemColor,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              width: 288,
              left: isSideMenuClosed ? -288 : 0,
              height: MediaQuery.of(context).size.height,
              child: const SideMenu()),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(animation.value -30 *animation.value * pi /  180),
            child: Transform.translate(
                offset: Offset(animation.value * 265, 0),
                child: Transform.scale(
                    scale: animationScal.value,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const HomePage()))),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            top: 16,
            left: isSideMenuClosed ? 6 : 220,
            curve: Curves.fastOutSlowIn,
            child: MenuButton(
              riveOnInit: (artboard) {
                StateMachineController controller = RiveUtils.getRiveController(
                    artboard,
                    stateMachineName: "State Machine");
                menuIsClosed = controller.findSMI("isOpen") as SMIBool;
                menuIsClosed.change(true);
                debugPrint(menuIsClosed.value.toString());
              },
              press: () {
                menuIsClosed.value = !menuIsClosed.value;
            
                if (isSideMenuClosed) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
            
                setState(() {
                  isSideMenuClosed = menuIsClosed.value;
                });
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100 * animation.value),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(left: 24, right: 24, bottom: 12),
            decoration: const BoxDecoration(
                color: AppConst.bottomLayoutColor,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                    bottomNavs.length,
                    (index) => GestureDetector(
                          onTap: () {
                            if (bottomNavs[index] != selectedItem) {
                              setState(() {
                                selectedItem = bottomNavs[index];
                              });
                            }
                            bottomNavs[index].input!.change(true);
                            Future.delayed(const Duration(seconds: 1), () {
                              bottomNavs[index].input!.change(false);
                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedBar(
                                isActivate: bottomNavs[index] == selectedItem,
                              ),
                              SizedBox(
                                height: 36,
                                width: 36,
                                child: Opacity(
                                  opacity:
                                      bottomNavs[index] == selectedItem ? 1 : 0.5,
                                  child: RiveAnimation.asset(
                                    bottomNavs[index].src,
                                    artboard: bottomNavs[index].artboard,
                                    onInit: (artboard) {
                                      StateMachineController controller =
                                          RiveUtils.getRiveController(artboard,
                                              stateMachineName: bottomNavs[index]
                                                  .stateMachineName);
        
                                      bottomNavs[index].input =
                                          controller.findSMI("active") as SMIBool;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
