import 'package:apay/classes/hex_color.dart';
import 'package:apay/classes/rive_utils.dart';
import 'package:apay/components/animated_bar.dart';
import 'package:apay/constants.dart';
import 'package:apay/models/hive_assets.dart';
import 'package:apay/widgets/home_page.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  RiveAsset selectedItem = bottomNavs.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(left: 24, right: 24, bottom: 12),
          decoration: BoxDecoration(
              color: Colors.black54,
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
                          Future.delayed(Duration(seconds: 1), () {
                            bottomNavs[index].input!.change(false);
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedBar(isActivate: bottomNavs[index] == selectedItem,),
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

if(bottomNavs[index].isSec){
bottomNavs[index].input = controller.findSMI("isActive") as SMIBool;
}else {
  bottomNavs[index].input = controller.findSMI("active") as SMIBool;
}

                                    
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
    );
  }
}




