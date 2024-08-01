import 'package:flutter/material.dart';

class CSOutlineButton extends StatefulWidget {
  final void Function()? onPressed;
  final String text;
  final String? iconPath;
  final ButtonStyle? style;

  const CSOutlineButton({
    super.key,
    this.onPressed,
    required this.text,
    this.iconPath,
    this.style,
  });

  @override
  State<CSOutlineButton> createState() => _CSOutlineButtonState();
}

class _CSOutlineButtonState extends State<CSOutlineButton> {
  Widget? _icon;

  @override
  void initState() {
    if(super.widget.iconPath != null) {
      _icon = ImageIcon(
        AssetImage(super.widget.iconPath!),
        color: widget.onPressed != null
            ? Colors.transparent
            : null,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPressed,
      style: widget.style,
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            if(_icon != null) _icon!,
            Container(
              alignment: Alignment.center,
              child: Text(widget.text),
            ),
          ],
        ),
      ),
    );
  }
}