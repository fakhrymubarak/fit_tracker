import 'package:flutter/material.dart';

// THEMES
ThemeData getAppTheme(BuildContext context) => ThemeData(
    colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: colorPrimary,
          onPrimary: colorWhite,
          secondary: colorSecondary,
          error: colorRedError,
        ),
    toggleableActiveColor: colorPrimary,
    textTheme: textTheme);

// COLORS
const colorPrimary = Color(0xFF08C0FF);
const colorPrimaryDisabled = Color(0xFF9CE6FF);
const colorSecondary = Color(0xFFFFA938);

const colorBlack = Color(0xFF090A0A);
const colorWhite = Color(0xFFFFFFFF);

const colorRedError = Color(0xFFE03C4C);
const colorRed20 = Color(0xFFF9EAEC);

const colorGray4 = Color(0xFF525A64);
const colorGray1 = Color(0xFFF1F4FA);

// BUTTON STYLES
ButtonStyle primaryButtonStyle([bool isEnabled = true]) => ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
          (isEnabled) ? colorPrimary : colorPrimaryDisabled),
      textStyle: MaterialStateProperty.all(textSemiBoldWhite_14pt),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

// TEXT STYLES
/// Regular, 14pt, white
const textRegularWhite_14pt = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  fontFamily: 'Poppins',
  color: colorWhite,
);

/// Regular, 14pt, Gray
const textRegularGray_14pt = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  fontFamily: 'Poppins',
  color: colorGray4,
);

/// Regular, 12pt, white
const textRegularWhite_12pt = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  fontFamily: 'Poppins',
  color: colorWhite,
);

/// Regular, 12pt, black
const textRegularBlack_12pt = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  fontFamily: 'Poppins',
  color: colorBlack,
);

/// Regular, 12pt, primary
const textRegularPrimary_12pt = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  fontFamily: 'Poppins',
  color: colorPrimary,
);

/// Regular, 10pt, white
const textRegularWhite_10pt = TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.w400,
  fontFamily: 'Poppins',
  color: colorWhite,
);

/// Medium, 12pt, Black
const textMediumBlack_12pt = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  fontFamily: 'Poppins',
  color: colorBlack,
);

/// Semi Bold, 20pt, Black
const textSemiBoldBlack_20pt = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  fontFamily: 'Poppins',
  color: colorBlack,
);

/// Semi Bold, 14pt, White
const textSemiBoldWhite_14pt = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  fontFamily: 'Poppins',
  color: colorWhite,
);

const textTheme = TextTheme(
  headline6: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 19,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15),
  subtitle1: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15),
  subtitle2: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1),
  bodyText1: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5),
  bodyText2: TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  button: TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  caption: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);
