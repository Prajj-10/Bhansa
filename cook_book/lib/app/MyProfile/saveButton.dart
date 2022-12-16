import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class Save_Button extends StatelessWidget {
  const Save_Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSaved = true;
    return LikeButton(
      bubblesSize: 0,
      circleSize: 0,
      likeBuilder: (bool isSaved){
        return Icon(
          isSaved? Icons.bookmark : Icons.bookmark_border_outlined, color: Colors.blue,
        );
      },
    );
  }
}
