import 'package:app_agenda/util/styles/cs_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum CSSnackBarActionType {
  success,
  error,
  warning,
  info,
}

class CSSnackBar extends SnackBar {
  final String? text;
  final IconData? icon;
  final Color? contentColor;
  final CSSnackBarActionType? actionType;

  CSSnackBar({
    super.key,
    this.text,
    this.icon,
    this.contentColor = Colors.white,
    this.actionType,
    Color? backgroundColor,
    Duration? duration,
  }) : super(
        duration: duration ?? const Duration(seconds: 4),
        content: Row(
        children: [
          Icon(
            icon ??
                switch (actionType) {
                  CSSnackBarActionType.success => Icons.check_circle_outline_outlined,
                  CSSnackBarActionType.error => Icons.error_outline_outlined,
                  CSSnackBarActionType.warning => Icons.warning_amber_outlined,
                  CSSnackBarActionType.info => Icons.info_outlined,
                  _ => null,
                },
            color: contentColor,
          ),
          icon != null || actionType != null 
              ? const Gap(12) 
              : const Gap(0),
          Flexible(
            child: Text(
              text!,
              style: TextStyle(
                color: contentColor,
              )
            )
          ),
        ],
      ),
      backgroundColor: backgroundColor ??
          switch (actionType) {
            CSSnackBarActionType.success => CSColors.secondarySwatch.color,
            CSSnackBarActionType.error => CSColors.error.color,
            CSSnackBarActionType.warning => CSColors.warning.color,
            CSSnackBarActionType.info => CSColors.primarySwatchV1.color,
            _ => null,
          },
      );
}
