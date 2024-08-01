import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SimplePageStructure extends StatelessWidget {
  static const double toolbarHeight = 32;
  static const double pagePadding = 32;
  final Widget child;
  const SimplePageStructure({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(SimplePageStructure.toolbarHeight + 2 * SimplePageStructure.pagePadding),
        child: Padding(
          padding: const EdgeInsets.all(SimplePageStructure.pagePadding),
          child: AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0,
            titleSpacing: 0,
            title: SvgPicture.asset('/images/logos/main/main_logo.svg',
              height: SimplePageStructure.toolbarHeight
            ),
            toolbarHeight: SimplePageStructure.toolbarHeight,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: SimplePageStructure.pagePadding,
              right: SimplePageStructure.pagePadding,
              bottom: SimplePageStructure.pagePadding,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
