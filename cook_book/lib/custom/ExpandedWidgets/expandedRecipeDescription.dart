import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
class ExpandedRecipeDescription extends StatelessWidget {
  var recipeDescription;

  ExpandedRecipeDescription({super.key, required this.recipeDescription});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        //height: 300,
        width: size.width,
        child: ReadMoreText(
          recipeDescription,
          trimLines: 2,
          textAlign: TextAlign.justify,
          trimMode: TrimMode.Line,
          trimCollapsedText: "more",
          trimExpandedText: "less",
          lessStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontSize: 14,
          ),
          moreStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontSize: 14,
          ),
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),

        ),
      );
  }
}
