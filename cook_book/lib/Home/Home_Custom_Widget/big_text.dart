import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  BigText({Key? key,
    this.color = Colors.white
    , required this.text,
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
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
