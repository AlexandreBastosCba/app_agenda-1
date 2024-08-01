// ignore_for_file: must_be_immutable

import 'package:app_agenda/util/styles/cs_colors.dart';
import 'package:flutter/material.dart';

class GroupRadioListTile extends StatefulWidget {
  final List<String> options;
  String? currentOption;
  final List<void Function()?>? onTaps;

  GroupRadioListTile({
    super.key,
    required this.options,
    this.currentOption = '',
    this.onTaps,
  });

  @override
  State<GroupRadioListTile> createState() => _GroupRadioListTileState();
}

class _GroupRadioListTileState extends State<GroupRadioListTile> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, builderSetState) {
      return Column(
        children: widget.options.map((String option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: widget.currentOption,
            onChanged: (String? value) {
              builderSetState(() {
                widget.currentOption = value!;
              });
              if (widget.onTaps != null) {
                widget.onTaps![widget.options.indexOf(value!)]!();
              }
            },
            activeColor: CSColors.primarySwatchV1.color,
          );
        }).toList(),
      );
    });
  }
}
