// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:app_agenda/util/styles/cs_colors.dart';
import 'package:app_agenda/util/widgets/actions/group_menu/group_menu.dart';

class GroupMenuListTile extends StatelessWidget {
  Function()? onTap;
  final IconData? leadingIcon;
  final String titleText;
  bool? enabled;

  GroupMenuListTile({
    super.key,
    this.onTap,
    this.leadingIcon,
    required this.titleText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enabled!,
      onTap: onTap,
      title: Text(titleText),
      leading: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: CSColors.foregroundV2.color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(
          leadingIcon,
          size: 19,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_outlined,
        size: 18,
      ),
      iconColor: CSColors.secondaryV1.color,
      titleTextStyle: TextStyle(
        color: CSColors.primary.color,
        fontSize: 15, 
        fontWeight: FontWeight.w300,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: GroupMenu.itemsVerticalPadding * 0.25,
        horizontal: GroupMenu.itemsHorizontalPadding,
      ),
    );
  }
}