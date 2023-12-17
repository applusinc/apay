import 'package:rive/rive.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(this.src,
      {required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset("assets/animicons/little_icons.riv",
      artboard: "HOME", stateMachineName: "HOME_interactivity", title: "HOME"),
  RiveAsset("assets/animicons/little_icons.riv",
      artboard: "DASHBOARD",
      stateMachineName: "DASHBOARD_interactivity",
      title: "DASHBOARD"),
  RiveAsset("assets/animicons/little_icons.riv",
      artboard: "BELL", stateMachineName: "BELL_Interactivity", title: "BELL"),
  RiveAsset("assets/animicons/little_icons.riv",
      artboard: "USER", stateMachineName: "USER_Interactivity", title: "USER")
];

List<RiveAsset> sideMenus = [
  RiveAsset("assets/animicons/little_icons.riv", artboard: "HOME", stateMachineName: "HOME_interactivity", title: "Anasayfa"),
   RiveAsset("assets/animicons/little_icons.riv", artboard: "SEARCH", stateMachineName: "SEARCH_Interactivity", title: "Arama"),
    RiveAsset("assets/animicons/little_icons.riv", artboard: "TIMER", stateMachineName: "TIMER_Interactivity", title: "Saat"),
     RiveAsset("assets/animicons/little_icons.riv", artboard: "BELL", stateMachineName: "BELL_Interactivity", title: "Zil")
];
List<RiveAsset> sideMenus2 = [
  RiveAsset("assets/animicons/little_icons.riv", artboard: "HOME", stateMachineName: "HOME_interactivity", title: "Anasayfa"),
   RiveAsset("assets/animicons/little_icons.riv", artboard: "SEARCH", stateMachineName: "SEARCH_Interactivity", title: "Arama"),
    RiveAsset("assets/animicons/little_icons.riv", artboard: "TIMER", stateMachineName: "TIMER_Interactivity", title: "Saat"),
];
