import 'package:cook_book/Home/Home_Custom_Widget/small_text.dart';
import 'package:flutter/material.dart';

import 'big_text.dart';

class InfoWidget2 extends StatelessWidget {
  const InfoWidget2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BigText(text: 'Popular', fontWeight: FontWeight.bold,),
            SizedBox(width: 10,),
            Container(
              child: BigText(text: ".",color: Colors.grey, fontWeight: FontWeight.bold,),
            ),
            SizedBox(width: 10,),
            Container(
              child: SmallText(text: "Food pairing"),
            ),

            //List of food and images


          ],

        )
    );
  }
}
