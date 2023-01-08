import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class Save_Button extends StatelessWidget {
  const Save_Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSaved = true;
    return IconButton(
      padding: EdgeInsets.all(0),
      icon: Icon(
        Icons.bookmark_border_outlined,
        size: 28,
        //isLiked ? Icons.favorite : Icons.favorite_border_outlined
      ), onPressed: () {  },

    );
  }
}
