// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:app_agenda/util/styles/cs_colors.dart';

class FlexibleLine extends StatelessWidget {
  late Color? color;
  final double tickness;

  FlexibleLine({
    this.color,
    this.tickness = 0.5,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: tickness,    
        color: color ?? CSColors.border.color,
      ),
    );
  }
}