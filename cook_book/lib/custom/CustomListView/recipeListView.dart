import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../CustomButtons/likebutton.dart';


class Recipe extends StatelessWidget {
  const Recipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*return SizedBox(
        width: size.width/2.5,

        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [


                Container(
                  color: Colors.grey,
                  height: 200,width: 300,
                  child: Image.network("https://img.freepik.com/premium-photo/tobacco-whole-chicken-plate-with-herbs-tomato-black-background-top-view-copy-space_89816-31697.jpg?w=2000", height: 200, width: 300,),
                ),
                // const SizedBox(width: 8,),
                const Text("Hello"),
                const Text("Bye"),




              ],
            ),
          ),
        )
    );*/
    return ListView.builder(
      primary: true,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 80,
      itemBuilder: (context, position){

      return Padding(
        padding: const EdgeInsets.only(bottom: 10, left:1, right: 1),
        child: Container(
          height: 100,
          width: size.width,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage("https://img.freepik.com/premium-photo/half-grilled-chicken-plate-black-background-top-view-copy-space_89816-10440.jpg?w=2000",),
              fit: BoxFit.cover,
            )
          ),
          child: Stack(
            children: [
              Positioned(
                left: 10,
                top: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Fried Chicken", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                      Text("Time: 1hrs 30min", style: TextStyle(color: Colors.white),),
                    ],
                  ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                //child: Text("Bye", style: TextStyle(color: Colors.white),),
                child: Likes_Button(),
              )
            ],
          ),

        ),
      );
    },
    );
  }
}
