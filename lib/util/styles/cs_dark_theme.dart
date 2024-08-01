import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_agenda/util/responsive/responsive.dart';
import 'package:app_agenda/util/styles/cs_colors.dart';

class CSDarkTheme {
  //Setting for divider themes
  static const double dividerIndent = 10;

  //Setting for search bar themes
  static const double desktopSearchBarFontSize = 16;
  static const double mobileSearchBarFontSize = 14;

  //Setting for input themes
  static const double inputHeight = 48;
  static final Color inputFocusColor = CSColors.primary.color;
  static final Color inputContentColor = CSColors.secondaryV1.color;
  static final InputBorder inputEnabledBorder = OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: CSColors.border.color
    ),
  );
  static final InputBorder inputFocusedBorder = OutlineInputBorder( 
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      width: 2,
      color: inputFocusColor,
    ),
  );
  static final TextStyle inputOutlineTextStyle = TextStyle(
    color: inputContentColor,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
  static final InputDecorationTheme specificInputDecorationTheme = InputDecorationTheme(
    filled: true,
    isCollapsed: true,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 20,
    ),
    floatingLabelStyle: TextStyle(
      color: inputFocusColor,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ),
    errorMaxLines: 5,
    helperMaxLines: 5,
    errorStyle: inputOutlineTextStyle.copyWith(
      color: CSColors.errorText.color,
    ),
    helperStyle: inputOutlineTextStyle.copyWith(
      color: CSColors.secondaryV1.color,
    ),
    enabledBorder: inputEnabledBorder,
    focusedBorder: inputFocusedBorder,
    errorBorder: inputEnabledBorder.copyWith(
      borderSide: inputEnabledBorder.borderSide.copyWith(
        color: CSColors.error.color,
      ),
    ),
    focusedErrorBorder: inputFocusedBorder.copyWith(
      borderSide: inputFocusedBorder.borderSide.copyWith(
        color: CSColors.error.color,
      ),
    ),
    disabledBorder: inputEnabledBorder.copyWith(
      borderSide: inputEnabledBorder.borderSide.copyWith(
        color: CSColors.border.color.withOpacity(0.1)
      ),
    ),
  );

  //Setting for Button Themes
  static final TextStyle buttonTextStyle = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static final Color buttonTextColor = CSColors.primary.color;
  static const double buttonMinHeight = 55;

  static ThemeData themeData(BuildContext context){
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.highContrastDark().copyWith(
        error: CSColors.errorText.color,
      ),
      scaffoldBackgroundColor: CSColors.background.color,

      sliderTheme: const SliderThemeData(
        showValueIndicator: ShowValueIndicator.always,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: CSColors.primarySwatchV1.color,
      ),

      dialogTheme: DialogTheme(
        backgroundColor: CSColors.card.color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
      ),

      tabBarTheme: TabBarTheme(
        labelColor: CSColors.primary.color,
        unselectedLabelColor: CSColors.secondaryV1.color,
        overlayColor: WidgetStateProperty.all<Color?>(Colors.transparent),
        indicatorColor: CSColors.primarySwatchV1.color,
        labelStyle: TextStyle(
          fontSize: Responsive.isDesktop(context) ? 17 : 14,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: Responsive.isDesktop(context) ? 16 : 14,
          fontWeight: FontWeight.w400,
        ),
      ),

      drawerTheme: DrawerThemeData(
        elevation: 0,
        backgroundColor: CSColors.inversePrimary.color,
        endShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),

      datePickerTheme: DatePickerThemeData(
        elevation: 1,
        backgroundColor: CSColors.card.color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))
        ),
      ),

      textSelectionTheme: TextSelectionThemeData(
        selectionColor: CSColors.textSelectionColor.color,
        selectionHandleColor: CSColors.textSelectionColor.color,
      ),

      cardTheme: CardTheme(
        margin: EdgeInsets.zero,
        color: CSColors.card.color,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))
        ),
      ),

      textTheme: GoogleFonts.figtreeTextTheme(
        Theme.of(context).textTheme,
      ).apply(
        bodyColor: CSColors.primary.color,
        displayColor: CSColors.primary.color,
      ),

      dividerTheme: DividerThemeData(
        thickness: 0.3,
        color: CSColors.primary.color,
        indent: dividerIndent,
        endIndent: dividerIndent,
      ),

      popupMenuTheme: PopupMenuThemeData(
        elevation: 0,
        color: CSColors.foregroundV1.color,
        position: PopupMenuPosition.under,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
      ),

      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all<Color?>(CSColors.primary.color),
        overlayColor: WidgetStateProperty.all<Color?>(Colors.black.withOpacity(0.2)),
        textStyle: WidgetStateProperty.all<TextStyle?>(
          TextStyle(
            color: CSColors.inversePrimary.color,
            fontSize: Responsive.isMobile(context) ? mobileSearchBarFontSize : desktopSearchBarFontSize,
          )
        ),
        hintStyle: WidgetStateProperty.all<TextStyle?>(
          TextStyle(
            color: const Color(0x73000000),
            fontSize: Responsive.isMobile(context) ? mobileSearchBarFontSize : desktopSearchBarFontSize,
          )
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: inputContentColor,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        suffixIconColor: inputContentColor, 
      ),

      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(CSColors.background.color),
          elevation: const WidgetStatePropertyAll(0),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              side: BorderSide(
                width: 0.8,
                color: CSColors.border.color,
              ),
            )
          ),
        ),
        inputDecorationTheme: CSDarkTheme.specificInputDecorationTheme,
      ),

      //Button Themes
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(CSColors.primary.color),
        )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: CSColors.primarySwatchV2.color,
          foregroundColor: buttonTextColor,
          textStyle: buttonTextStyle,
          minimumSize: const Size.fromHeight(buttonMinHeight),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: buttonTextColor,
          textStyle: buttonTextStyle,
          minimumSize: const Size.fromHeight(buttonMinHeight),
          side: BorderSide(
            width: 0.8,
            color: CSColors.border.color,
          ),
        ),  
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor:CSColors.secondaryV1.color,
          textStyle: buttonTextStyle,
          minimumSize: const Size.fromHeight(buttonMinHeight),
        ),
      ),
    );
  }
}
