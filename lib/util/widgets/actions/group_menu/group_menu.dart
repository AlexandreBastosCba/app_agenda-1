import 'package:app_agenda/util/styles/cs_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:app_agenda/util/widgets/actions/group_menu/group_menu_list_tile.dart';

class GroupMenu extends StatelessWidget {
  static const double itemsVerticalPadding = 15;
  static const double itemsHorizontalPadding = itemsVerticalPadding * 0.8;
  final List<GroupMenuListTile> tiles;
  final String title;

  const GroupMenu({
    required this.title,
    required this.tiles,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: itemsVerticalPadding,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(
                horizontal: itemsHorizontalPadding,
                vertical: itemsVerticalPadding,
              ),
              child: Text(
                title,
                style: CSTextSyles.smallTitle(context),
              ),
            ),
            ListBody(
              children: tiles,
            ),
          ]
        )
      )
    );
  }
}