import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  static const double divisionPoint = 750;
  final bool fullScreenOption;
  final Widget desktop;
  final Widget mobile;

  const Responsive({
    this.fullScreenOption = false,
    required this.desktop,
    required this.mobile,
    super.key,
  });

  const Responsive.fullScreen({
    fullScreenOption = true,
    required desktop,
    required mobile,
    Key? key,
  }) : this(
          fullScreenOption: fullScreenOption,
          desktop: desktop,
          mobile: mobile,
          key: key,
        );

  //métodos para retornar o tamanho de cada dispositivo
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= Responsive.divisionPoint;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < Responsive.divisionPoint;

  static bool isMobileS(BuildContext context) =>
      MediaQuery.of(context).size.width < 375;

  @override
  Widget build(BuildContext context) {
    if (fullScreenOption) {
      if (MediaQuery.of(context).size.width >= Responsive.divisionPoint) {
        return desktop;
      } else {
        return mobile;
      }
    } else {
      return LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth >= Responsive.divisionPoint) {
          return desktop;
        } else {
          return mobile;
        }
      });
    }
  }
}
