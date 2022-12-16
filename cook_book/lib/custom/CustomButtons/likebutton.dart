import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class Likes_Button extends StatelessWidget {
   Likes_Button({Key? key}) : super(key: key);
  var buttonSize=25.0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 30,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFF000000).withOpacity(0.5),
      ),

      child: LikeButton(
        size: buttonSize,
        circleColor:
        CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
        bubblesColor: BubblesColor(
          dotPrimaryColor: Color(0xff33b5e5),
          dotSecondaryColor: Color(0xff0099cc),
        ),
        likeBuilder: (bool isLiked) {
          return Icon(
            Icons.heart_broken,
            color: isLiked ? Colors.red : Colors.grey,
            size: buttonSize,
          );
        },
        likeCount: 100,
        countBuilder: (int? count, bool isLiked, String text) {
          var color = isLiked ? Colors.white : Colors.grey;
          if (count == 0) {
             return Text(
              "Likes",
              style: TextStyle(color: color),
            );
          }

             return Text(
              text,
              style: TextStyle(color: color),
            );
        },
      ),
    );
  }
}

