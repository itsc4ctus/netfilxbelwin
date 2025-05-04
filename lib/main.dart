import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflixclone/domain/core/colors/colors.dart';
import 'package:netflixclone/presentation/main_page/screen_main.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.montserrat().fontFamily,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor:backgroundColor,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white

          ),
          bodySmall: TextStyle(
            color: Colors.white
          )
        )
      ),
      home: ScreenMainPage(

      ),
    );
  }
}
