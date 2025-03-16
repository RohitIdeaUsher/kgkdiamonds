import 'package:flutter/material.dart';

import '../models/popup_model.dart';

class AppPopup {
  static Future<void> showPopupMenu(
      {required BuildContext context,
      required Offset offset,
      List<PopUpModel>? popupList}) async {
    if (popupList != null) {
      await showMenu(
        context: context,
        constraints: null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        position:
            RelativeRect.fromLTRB(offset.dx, offset.dy, offset.dx, offset.dy),
        items: List.generate(popupList.length, (index) {
          PopUpModel popUpModel = popupList[index];
          return PopupMenuItem(
              onTap: popUpModel.onTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (popUpModel.iconData != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(popUpModel.iconData, color: Colors.black),
                    ),
                  Text(
                    popUpModel.title ?? "Popup Text",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ],
              ));
        }),
        elevation: 8.0,
      );
    }
  }
}
