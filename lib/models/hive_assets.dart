import 'package:rive/rive.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;
  bool isSec;

  RiveAsset(this.src,
      {required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.input, required this.isSec});

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset("assets/animicons/riveicons.riv",
      artboard: "HOME", stateMachineName: "HOME_Interactivity", title: "Home", isSec: false),
  RiveAsset("assets/animicons/riveicons2.riv",
      artboard: "DASHBOARD",
      stateMachineName: "State Machine 1",
      title: "Dashboard", isSec: true),
  RiveAsset("assets/animicons/riveicons2.riv",
      artboard: "BELL", stateMachineName: "BELL_Interactivity", title: "BELL", isSec: false),
  RiveAsset("assets/animicons/riveicons2.riv",
      artboard: "USER", stateMachineName: "USER_Interactivity", title: "USER", isSec: false)
];
