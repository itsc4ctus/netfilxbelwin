import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflixclone/domain/core/constants/constants.dart';


class AppBarWidget extends StatelessWidget {
  final String title;
  const AppBarWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          kWidth,
          Text(title,
          style: GoogleFonts.montserrat(
           fontSize: 25,
            fontWeight: FontWeight.w700
          ),
          ),
          Spacer(),
          Icon(Icons.cast,color: Colors.white,),
          kWidth,
          Container(color: Colors.blue,
          height: 30,
            width: 30,
          ),
          kWidth
        ],
      ),
    );
  }
}
