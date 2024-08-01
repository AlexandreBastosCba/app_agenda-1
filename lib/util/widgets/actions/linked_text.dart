import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_agenda/util/styles/cs_colors.dart';

class LinkedText extends StatefulWidget {
  final Function()? onTap;
  final String text;
  final Alignment alignment;
  final EdgeInsetsGeometry margin;
  final bool hoverColorOnlyUnderline;

  const LinkedText({
    required this.onTap,
    required this.text,
    this.alignment = Alignment.center,
    this.margin = EdgeInsets.zero,
    this.hoverColorOnlyUnderline = false,
    super.key,
  });

  @override
  State<LinkedText> createState() => _LinkedTextState();
}

class _LinkedTextState extends State<LinkedText> {
  final Color _defaultColor = CSColors.primary.color;
  final Color _hoverColor = CSColors.primarySwatchV2.color;
  late Color _textColor, _underlineColor;

  @override
  void initState() {
    _textColor = _defaultColor;
    _underlineColor = _defaultColor;
    super.initState();
  }

  void changeColor(bool value) {
    if(value) {
      _textColor = _hoverColor;
      _underlineColor = _hoverColor;
    } else {
      _textColor = _defaultColor;
      _underlineColor = _defaultColor;
    }
  }

  void changeUnderlineColor(bool value) {
    if(value){
      _underlineColor = _hoverColor;
    } else {
      _underlineColor = _defaultColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      alignment: widget.alignment,
      child: InkWell(
        onTap: widget.onTap,
        onHover: (value) {
          setState(() {
            if(widget.hoverColorOnlyUnderline) {
              changeUnderlineColor(value);
            } else {
              changeColor(value);
            }
          });
        },
        onHighlightChanged: (value) {
          setState(() {
            if(widget.hoverColorOnlyUnderline) {
              changeUnderlineColor(value);
            } else {
              changeColor(value);
            }
          });
        },
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            height: 1,
            color: _textColor,
            fontSize: 15,
            letterSpacing: 0.6,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
            decorationThickness: 2,
            decorationColor: _underlineColor,
          ),
        ),
      ),
    );
  }
}