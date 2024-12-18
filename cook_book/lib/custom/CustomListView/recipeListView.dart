import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../../app/RecipeDetail_Page/recipeDetails.dart';
import '../CustomButtons/likebutton.dart';


class Recipe extends StatelessWidget {

  //User? user = FirebaseAuth.instance.currentUser;

  var userId;
  //var reference;

  Recipe({super.key, required this.userId});


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var recipeReference = FirebaseFirestore.instance.collection("recipe_details");
    return StreamBuilder(
      //stream: FirebaseFirestore.instance.collection('recipe_details').snapshots(),
      stream: recipeReference.where('Posted By', isEqualTo:userId).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.none:
            return Container(
              child: Text("Try loading again"),
            );

          case ConnectionState.waiting:
            return Container(
              height: 80,
                width: 80,
                child: CircularProgressIndicator(color: Color(0xFF09274A),)
            );
          case ConnectionState.active:
          case ConnectionState.done:

            if(snapshot.hasData){
              //no data
              return ListView.builder(
                padding: EdgeInsets.only(top: 2),
                primary: true,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index){
                  final DocumentSnapshot recipe_Snapshot = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> RecipeDetails(recipe_snapshot: recipe_Snapshot),),);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10, left:1, right: 1),
                      child: Container(
                        height: 100,
                        width: size.width,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueGrey,
                            image: DecorationImage(
                              //image: NetworkImage("https://img.freepik.com/premium-photo/half-grilled-chicken-plate-black-background-top-view-copy-space_89816-10440.jpg?w=2000",),
                              image: NetworkImage(recipe_Snapshot['Photo']??"https://img.freepik.com/free-vector/graphic-design-vector-illustration_24908-54512.jpg?w=2000"),

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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(recipe_Snapshot['Title']??"null", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                                  Text("Time: " +recipe_Snapshot['Total Duration'] ?? "null", style: TextStyle(color: Colors.white),),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 3,
                              //child: Text("Bye", style: TextStyle(color: Colors.white),),
                              child: Container(
                                height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                  child: Likes_Button(recipeId: recipe_Snapshot.id,)
                              ),
                            )
                          ],
                        ),

                      ),
                    ),
                  );
                },
              );

            }
            else{
              return Center(
                child: const Text("No data available",style: TextStyle(color: Colors.white, fontSize: 16),),
              );
            }
        }


      }
    );
  }
}
