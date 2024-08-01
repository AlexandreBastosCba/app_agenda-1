import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_agenda/util/responsive/responsive.dart';

class CSTextSyles {

  static TextStyle largeTitle(BuildContext context){
    return TextStyle(
      fontSize: Responsive.isDesktop(context) ? 45 : 40,
      fontWeight: FontWeight.bold,
    );
  }
  
  static TextStyle mediumTitle(BuildContext context){
    return TextStyle(
      fontSize: Responsive.isDesktop(context) ? 24 : 18,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle smallTitle(BuildContext context){
    return const TextStyle(
      fontSize: 16,
      letterSpacing: 0.75,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle decoratedTitle(BuildContext context){
    return GoogleFonts.oleoScript(
      fontSize: Responsive.isDesktop(context) ? 39 : 32,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle alertText(BuildContext context){
    return const TextStyle(
      fontSize: 16,
      letterSpacing: 0.75,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle decoratedMediumText(){
    return GoogleFonts.oleoScript(
      fontSize: 18,
      fontWeight: FontWeight.w200,
    );
  }
}