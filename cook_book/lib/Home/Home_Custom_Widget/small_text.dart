import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  double height;
  FontWeight fontWeight;
  SmallText({Key? key,
    this.color = const Color(0xFFCBC9C9)
    , required this.text,
    this.fontWeight = FontWeight.normal,
    this.height = 1.2,
    this.size = 12}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sora(
        textStyle: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
          height: height,
        ),
      ),
    );
  }
}
