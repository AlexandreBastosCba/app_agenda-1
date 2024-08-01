import 'package:flutter/material.dart';
import 'package:app_agenda/util/styles/cs_colors.dart';   

class CSBackButton extends StatelessWidget {
  final void Function()? onPressed;

  const CSBackButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back_ios_outlined),
      iconSize: 25,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(CSColors.foregroundV2.color),
        padding: WidgetStateProperty.all(const EdgeInsets.all(12)),
      ),
    );
  }
}
