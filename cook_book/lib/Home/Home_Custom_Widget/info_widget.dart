import 'package:cook_book/Home/Home_Custom_Widget/big_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/SearchUser/SearchPerson.dart';

class InfoWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //Information
    return Container(
        margin: EdgeInsets.only(top:10, bottom: 15),
        padding: EdgeInsets.only(left: 20, right: 20),
        //color: Colors.blue,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BigText(text: "WHAT YOU WILL MAKE \n TODAY ?", size: 22, fontWeight: FontWeight.w700),
            
            //TopRight Search Icon Button
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFF89dad0),
                ),

                child: IconButton(

                    onPressed: () => showSearch(context: context, delegate: SearchPerson()),
                    icon: Icon(Icons.search_rounded)),
              ),
            ),
          ],
        ),

      );
  }

}