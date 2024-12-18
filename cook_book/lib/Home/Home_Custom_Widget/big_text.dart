import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  FontWeight fontWeight;
  BigText({Key? key,
    this.color = const Color(0xFFFFFFFF)
    , required this.text,
    this.fontWeight = FontWeight.w400,
    this.overFlow = TextOverflow.ellipsis,
    this.size = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      style: GoogleFonts.sora(
        textStyle: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
