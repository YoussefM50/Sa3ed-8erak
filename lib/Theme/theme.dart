import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color skyblue = Color.fromRGBO(135, 206, 235, 1);
const Color salmon = Color.fromRGBO(250, 128, 114, 1);
const Color palegreen = Color.fromRGBO(152, 251, 152, 1);
const Color white = Colors.white;
const primaryClr = Colors.green;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);
const Color lightgray = Color.fromRGBO(220, 220, 220, 1);
const String projectLogo = "lib/img/img5.jpg";

class Themes {
  static final light = ThemeData(
    primarySwatch: primaryClr,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: primaryClr, fontSize: 20),
      backgroundColor: Colors.white,
      elevation: 3,
      centerTitle: true,
      iconTheme: IconThemeData(
        color:primaryClr 
      ),
    ),
  );
  static final dark = ThemeData(
    primarySwatch: primaryClr,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkHeaderClr,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      backgroundColor: darkHeaderClr,
      elevation: 3,
      centerTitle: true,
    ), //AppBarTheme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryClr,
    ), //FloatingActionButtonThemeData
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkHeaderClr,
      selectedItemColor: primaryClr,
      unselectedItemColor: lightgray,
    ), //BottomNavigationBarThemeData
  );
}

TextStyle get Headingstyle {
  return GoogleFonts.lato(
    textStyle:const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,),
  );
}

TextStyle get SubHeadingstyle {
  return GoogleFonts.lato(
    textStyle:const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,),
  );
}

TextStyle get Titlestyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,),
  );
}

TextStyle get SubTitlestyle {
  return GoogleFonts.lato(
    textStyle:const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
),
  );
}

TextStyle get Bodylestyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.grey[400] : Colors.black),
  );
}

TextStyle get Body2lestyle {
  return GoogleFonts.lato(
    textStyle:const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,),
  );
}
