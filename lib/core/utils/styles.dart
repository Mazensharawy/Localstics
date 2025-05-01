import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getTextStyle({Color color= Colors.black, double fontSize = 18, FontWeight fontweight = FontWeight.normal, TextDecoration? decoration, Color? decorationColor, }){
  return TextStyle(color: color,
                   fontSize: fontSize,
                   fontWeight: fontweight,
                   fontFamily: GoogleFonts.aleo().fontFamily,
                   decoration: decoration,
                   decorationColor: decorationColor,
                  );
}