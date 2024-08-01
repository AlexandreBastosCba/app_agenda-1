import 'package:app_agenda/util/responsive/responsive.dart';
import 'package:flutter/material.dart';

class CardIconButton extends Container {
  CardIconButton(BuildContext context, {
    super.key,
    void Function()? onPressed,
    required IconData icon
  }) : super(
        width: Responsive.isDesktop(context) ? 36 : 32,
        height: Responsive.isDesktop(context) ? 36 : 32,
        margin: const EdgeInsets.only(
          top: 8,
          right: 8,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black.withOpacity(0.45),
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(0),
          ),
          child: Icon(
            icon,
            size: Responsive.isDesktop(context) ? 20 : 18,
          ),
        ),
      );
}
