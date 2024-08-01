import 'package:flutter/material.dart';
import 'package:app_agenda/util/responsive/responsive.dart';

class CSPopupMenuItem {

  static PopupMenuItem<int> add({
      required BuildContext context,
      required int value,
      void Function()? onTap,
      required String text,
      required IconData icon,
      bool? enabled = true,
  }) {
    return PopupMenuItem<int>(
      value: value,
      onTap: onTap,
      enabled: enabled!,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(
              right: 10,
            ),
            child: Icon(
              icon,
              size: Responsive.isDesktop(context) ? 20 : 16,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: Responsive.isDesktop(context) ? 14 : 11,
            ),  
          ),
        ], 
      ),
    );
  }
}