import 'package:flutter/material.dart';
import 'package:app_agenda/util/styles/cs_colors.dart';

class ContainerBorderAnimated extends StatefulWidget {
  final Widget child;

  const ContainerBorderAnimated({
    required this.child,
    super.key,
  });

  @override
  State<ContainerBorderAnimated> createState() =>
      _ContainerBorderAnimatedState();
}

class _ContainerBorderAnimatedState extends State<ContainerBorderAnimated> {
  late double _borderSize;
  late double _sideMargins;
  late BoxDecoration _mainBoxDecoration;
  final BoxDecoration _voidBoxDecoration = const BoxDecoration();
  late final BoxDecoration _completedBoxDecoration = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        width: _borderSize,
        color: CSColors.animatedBorder.color,
      ),
    ),
  );

  @override
  void initState() {
    _borderSize = 2.5;
    _sideMargins = 20;
    _mainBoxDecoration = _voidBoxDecoration;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(
        left: _sideMargins,
        right: _sideMargins,
      ),
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
      decoration: _mainBoxDecoration,
      child: Material(
        color: const Color(0x00FFFFFF),
        child: InkWell(
          onTap: () {},
          onHover: (context) {
            setState(() {
              if (_mainBoxDecoration == _voidBoxDecoration) {
                _mainBoxDecoration = _completedBoxDecoration;
              } else {
                _mainBoxDecoration = _voidBoxDecoration;
              }
            });
          },
          child: super.widget.child,
        ),
      ),
    );
  }
}
