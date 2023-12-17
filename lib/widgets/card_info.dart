// ignore_for_file: must_be_immutable

import 'package:apay/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  String name, userID;
   CardInfo({
    super.key,
    required this.name,
    required this.userID,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(userID),
      leading: CircleAvatar(
          backgroundColor: AppConst.avatarBackground,
          child: Icon(
            CupertinoIcons.person,
            color: AppConst.avatar,
          )),
    );
  }
}