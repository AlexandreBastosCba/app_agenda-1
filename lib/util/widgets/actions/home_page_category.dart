import 'package:app_agenda/util/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:app_agenda/util/styles/cs_colors.dart';

class HomePageCategory extends StatefulWidget {
  final String text;
  final IconData? iconData;
  final String? iconPath;
  final void Function()? onTap;

  const HomePageCategory({
    super.key,
    required this.text,
    this.iconData,
    this.iconPath,
    this.onTap,
  });

  @override
  State<HomePageCategory> createState() => _HomePageCategoryState();
}

class _HomePageCategoryState extends State<HomePageCategory> {
  static const double containerMargin = 7.5;
  late double containerWidth;
  late double iconSize;
  final Color iconColor = CSColors.primary.color;

  //Cores para realizar animação de hover
  final Color defaultTextColor = CSColors.primary.color;
  final Color defaultBorderSideColor = CSColors.inversePrimary.color;
  final Color hoverColor = CSColors.primarySwatchV1.color;
  late Color textColor, borderSideColor;

  //Define as cores inicias do texto e da borda
  @override
  void initState() {
    super.initState();
    textColor = defaultTextColor;
    borderSideColor = defaultBorderSideColor;
  }

  //Função que altera as cores do texto e da borda
  void changeColor(bool value) {
    if(value) {
      textColor = hoverColor;
      borderSideColor = hoverColor;
    } else {
      textColor = defaultTextColor;
      borderSideColor = defaultBorderSideColor;
    }
  }

  double responsiveProportion(context) {
    return (Responsive.isMobile(context) ? 0.80 : 1);
  }
  
  @override
  Widget build(BuildContext context) {
    containerWidth = 105 * responsiveProportion(context);
    iconSize = 35 * responsiveProportion(context);

    return Container(
      height: 160 * responsiveProportion(context),
      width: containerWidth,
      margin: const EdgeInsets.only(
        left: containerMargin,
        right: containerMargin,
      ),
      child: InkWell(
        onTap: () async {
          setState(() {
            changeColor(true);
          });
          await Future.delayed(const Duration(milliseconds: 75));  
          setState(() {
            changeColor(false);
          });
          widget.onTap?.call();
        },
        onHover: (value) {
          setState(() {
            changeColor(value);
          });
        },
        onHighlightChanged: (value) {
          setState(() {
            changeColor(value);
          });
        },
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          children: [
            Container( 
              height: containerWidth,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: CSColors.backgroundV1.color,
                borderRadius: BorderRadius.circular(90),
                border: Border.all(
                  width: 0.5,
                  color: borderSideColor,
                  style: BorderStyle.solid,
                )
              ),
              child: widget.iconData != null 
                ? Icon(
                  widget.iconData,
                  color: iconColor,
                  size: iconSize,
                ) 
                : ImageIcon(
                  AssetImage(widget.iconPath!),
                  color: iconColor,
                  size: iconSize,
                ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 8
              ),
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12 - (Responsive.isMobile(context) ? 1 : 0),
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}