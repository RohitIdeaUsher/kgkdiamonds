import 'package:flutter/material.dart';

class PopUpModel {
  String? id;
  String? title;
  IconData? iconData;
  Function()? onTap;

  PopUpModel({
    this.id,
    this.title = "",
    this.iconData,
    this.onTap,
  });
}
