import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../CustomButtons/likebutton.dart';


class Recipe extends StatelessWidget {

  //User? user = FirebaseAuth.instance.currentUser;

  var userId;
  var reference;

  Recipe({super.key, required this.reference, required this.userId});


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      //stream: FirebaseFirestore.instance.collection('recipe_details').snapshots(),
      stream: reference.where('Posted By', isEqualTo:userId).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        /*switch(snapshot.connectionState){
          case ConnectionState.none:
            return Container(
              child: Text("Try loading again"),
            );
          case ConnectionState.active:
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.done:
            if(!snapshot.hasData){
              //no data
              return Container(
                child: const Text("No data available"),
              );
            }
            else{

            }
        }*/

        return ListView.builder(
          primary: true,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index){
            final DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10, left:1, right: 1),
              child: Container(
                height: 100,
                width: size.width,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: DecorationImage(
                      //image: NetworkImage("https://img.freepik.com/premium-photo/half-grilled-chicken-plate-black-background-top-view-copy-space_89816-10440.jpg?w=2000",),
                      image: NetworkImage(docSnapshot['Photo']??"https://img.freepik.com/free-vector/graphic-design-vector-illustration_24908-54512.jpg?w=2000"),

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
                          Text(docSnapshot['Title']??"null", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                          Text(docSnapshot['Total Duration'] ?? "null", style: TextStyle(color: Colors.white),),
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
    );
  }
}
