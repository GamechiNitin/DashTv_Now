import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kPrimaryColor = Colors.black;
const Color kMainColor = Colors.amber;
const Color kMain2Color = Colors.deepOrange;
const Color kSecondaryColor = Color(0xFF0044CC);
const Color kBackgroundColor = Color(0xFFF8F9FA);
const Color kCardColor = Color(0xFFFFFFFF);
const Color kTextColor = Color(0xFF1A1A1A);
const Color kSubtitleColor = Color(0xFF6C757D);
const Color kBorderColor = Color(0xFFE0E0E0);
const Color kWhiteColor = Colors.white;
const Color kBlackColor = Colors.black;
const Color kBlack54Color = Colors.black54;

final ThemeData dashTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: kBackgroundColor,

  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    bodyLarge: const TextStyle(color: kTextColor, fontSize: 16),
    bodyMedium: const TextStyle(color: kSubtitleColor, fontSize: 14),
    titleLarge: const TextStyle(
      color: kTextColor,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 18,
      letterSpacing: 1.2,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  ),

  tabBarTheme: const TabBarThemeData(
    labelColor: kPrimaryColor,
    unselectedLabelColor: kBlack54Color,
    indicatorColor: kPrimaryColor,
  ),

  cardColor: kCardColor,

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(kPrimaryColor),
      foregroundColor: const WidgetStatePropertyAll(kWhiteColor),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      textStyle: WidgetStatePropertyAll(
        GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kPrimaryColor,
    foregroundColor: kWhiteColor,
  ),

  iconTheme: const IconThemeData(color: kPrimaryColor),
  dividerColor: kBorderColor,
);
