import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class Likes_Button extends StatefulWidget {
  var recipeId;
   Likes_Button({Key? key, required this.recipeId}) : super(key: key);

  @override
  State<Likes_Button> createState() => _Likes_ButtonState();
}

class _Likes_ButtonState extends State<Likes_Button> {
  int likeCount=0;
  var currentUserId = FirebaseAuth.instance.currentUser?.uid;
  var recipeReference = FirebaseFirestore.instance.collection("recipe_details");
  List like_list = [];

  Future<void> handleLike() async{
    try{
      if(like_list.contains(currentUserId)){
        await recipeReference.doc(widget.recipeId)
            .update({
          'Likes':FieldValue.arrayRemove([currentUserId]),
        });
      }else {
        await recipeReference.doc(widget.recipeId)
            .update({
          'Likes':FieldValue.arrayUnion([currentUserId]),
        });
      };
    } catch(e){
      print(e.toString());
    }

  }

  void getLikes() async{
    var like_ref = await FirebaseFirestore.instance.collection('recipe_details').doc(widget.recipeId).get();
    setState(() {
      like_list = like_ref.data()!['Likes'];
      likeCount = like_list.length-1;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    getLikes();
    //likeCount = getLikeCount();
    //likeCount = widget.likes_map.length.toInt()-1;
    //isLiked = (likes[currentUserId]==true);
    return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              padding: EdgeInsets.all(0),
              onPressed: handleLike,
              icon: Icon(
                  like_list.contains(currentUserId)? Icons.favorite : Icons.favorite_border_outlined,
                  color: like_list.contains(currentUserId)?  Colors.red : Colors.grey,
                  size: 28,
                  //isLiked ? Icons.favorite : Icons.favorite_border_outlined
              ),

            ),
            Text(likeCount.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
          ],
        ),
    );

      /*Container(
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
            isLiked ? Icons.favorite : Icons.favorite_border_outlined,
            color: isLiked ? Colors.red : Colors.grey,
            size: buttonSize,
          );
        },
        *//*likeCount: getLikeCount(),
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
        },*//*
      ),
    );*/
  }
}

