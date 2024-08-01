import 'package:app_agenda/util/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:app_agenda/util/styles/cs_colors.dart';

class EmphasisContainer extends StatelessWidget {
  static const double borderEllipticalRadiusX = 50;
  static const double borderEllipticalRadiusY = 50;
  final Widget child;
  
  const EmphasisContainer({
    required this.child,
    super.key,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200 * (Responsive.isMobile(context) ? 0.80 : 1),
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: CSColors.foreground.color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(borderEllipticalRadiusX, borderEllipticalRadiusY),
            bottomRight: Radius.elliptical(borderEllipticalRadiusX, borderEllipticalRadiusY),
          ),
        ),
      ),
      child: child,
    );
  }
}
