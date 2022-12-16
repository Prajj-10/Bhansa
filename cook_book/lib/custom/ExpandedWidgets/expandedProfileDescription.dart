import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ExpandedProfileDescription extends StatelessWidget {

  //Variables
  final String profileDescription;

  //ExpandedProfileDescription(String s, {Key? key, required this.profileDescription}) : super(key: key);
  const ExpandedProfileDescription({super.key, required this.profileDescription, });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        //height: 300,
        width: size.width,
        child: ReadMoreText(
          profileDescription,
          trimLines: 2,
          textAlign: TextAlign.justify,
          trimMode: TrimMode.Line,
          trimCollapsedText: "Show More",
          trimExpandedText: "Show Less",
          lessStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
            fontSize: 14,
          ),
          moreStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
            fontSize: 14,
          ),
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),

        ),
      ),
    );
  }
}


